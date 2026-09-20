#!/bin/bash
#
# Blue Archive Cursor Installer
# 蔚蓝档案鼠标指针一键安装脚本
#
# This script installs the Blue Archive style cursors on Linux systems.
# 此脚本在 Linux 系统上一键安装蔚蓝档案风格鼠标指针。
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CURSOR_THEME_NAME="BlueArchive"
CURSOR_THEME_DIR="$HOME/.icons/$CURSOR_THEME_NAME"
SYSTEM_CURSOR_DIR="/usr/share/icons/$CURSOR_THEME_NAME"

echo "========================================================"
echo "  Blue Archive Cursor Installer"
echo "  蔚蓝档案鼠标指针一键安装工具"
echo "========================================================"
echo ""

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo -e "${YELLOW}提示：检测到以 root 身份运行${NC}"
    INSTALL_MODE="system"
else
    echo -e "${BLUE}将以用户模式安装 (无需 root 权限)${NC}"
    echo "如需系统级安装，请使用 sudo 运行此脚本"
    echo ""
    INSTALL_MODE="user"
fi

# Function to convert SVG to PNG cursor
convert_cursor() {
    local svg_file="$1"
    local output_file="$2"
    local size="${3:-32}"
    
    if command -v rsvg-convert &> /dev/null; then
        rsvg-convert -w $size -h $size "$svg_file" -o "$output_file" 2>/dev/null
        return 0
    elif command -v convert &> /dev/null; then
        convert -background none -resize ${size}x${size} "$svg_file" "$output_file" 2>/dev/null
        return 0
    elif python3 -c "import cairosvg" &> /dev/null; then
        python3 -c "
import cairosvg
cairosvg.svg2png(url='$svg_file', write_to='$output_file', output_width=$size, output_height=$size)
" 2>/dev/null
        return 0
    else
        return 1
    fi
}

# Function to create cursor from PNG with hotspot
create_xcursor() {
    local png_file="$1"
    local cursor_file="$2"
    local hotspot_x="${3:-0}"
    local hotspot_y="${4:-0}"
    
    if command -v xcursorgen &> /dev/null; then
        # Create config file for xcursorgen
        local temp_config=$(mktemp)
        echo "$hotspot_x $hotspot_y $png_file $cursor_file" > "$temp_config"
        xcursorgen -n "$temp_config" "$(dirname "$cursor_file")" 2>/dev/null
        rm -f "$temp_config"
        return 0
    else
        # Fallback: just copy PNG (limited support)
        cp "$png_file" "$cursor_file"
        return 0
    fi
}

# Detect available tools
echo -e "${BLUE}检查所需工具...${NC}"
TOOLS_AVAILABLE=true

if ! command -v xcursorgen &> /dev/null; then
    echo -e "${YELLOW}警告：未找到 xcursorgen，将使用简化安装方式${NC}"
    echo "      建议安装：sudo apt install xcursorutils (Debian/Ubuntu)"
    echo "               sudo dnf install xcurisorutils (Fedora)"
    TOOLS_AVAILABLE=false
fi

echo ""

# Choose installation directory
if [ "$INSTALL_MODE" = "system" ]; then
    TARGET_DIR="$SYSTEM_CURSOR_DIR"
    echo -e "${BLUE}将安装到系统目录：$TARGET_DIR${NC}"
    sudo mkdir -p "$TARGET_DIR"
else
    TARGET_DIR="$CURSOR_THEME_DIR"
    echo -e "${BLUE}将安装到用户目录：$TARGET_DIR${NC}"
    mkdir -p "$TARGET_DIR"
fi

# Create cursors subdirectory
CURSORS_SUBDIR="$TARGET_DIR/cursors"
mkdir -p "$CURSORS_SUBDIR"

echo ""
echo -e "${BLUE}开始转换和安装指针文件...${NC}"
echo ""

# Define cursor mappings (SVG -> cursor name -> hotspot x, hotspot y)
declare -A CURSOR_MAP=(
    ["blue_archive_cursor_normal.svg"]="default:8:4 arrow:8:4"
    ["blue_archive_cursor_link.svg"]="copy:16:8 link:16:8"
    ["blue_archive_cursor_text.svg"]="text:16:16 ibeam:16:16"
    ["blue_archive_cursor_precision.svg"]="precision:16:16 crosshair:16:16"
    ["blue_archive_cursor_wait.svg"]="wait:16:16 watch:16:16"
    ["blue_archive_cursor_busy.svg"]="progress:16:16 left_ptr_watch:16:16"
    ["blue_archive_cursor_help.svg"]="help:16:16 question_arrow:16:16"
    ["blue_archive_cursor_unavailable.svg"]="no_drop:16:16 forbidden:16:16"
    ["blue_archive_cursor_vertical_resize.svg"]="v_double_arrow:16:16 ns_resize:16:16"
    ["blue_archive_cursor_horizontal_resize.svg"]="h_double_arrow:16:16 ew_resize:16:16"
    ["blue_archive_cursor_diagonal_resize.svg"]="fd_double_arrow:16:16 nwse_resize:16:16"
    ["blue_archive_cursor_move.svg"]="move:16:16 all-scroll:16:16"
)

SUCCESS_COUNT=0
TOTAL_COUNT=0

for svg_file in blue_archive_cursor_*.svg; do
    if [ ! -f "$svg_file" ]; then
        continue
    fi
    
    TOTAL_COUNT=$((TOTAL_COUNT + 1))
    
    # Get cursor names and hotspot for this SVG
    cursor_info="${CURSOR_MAP[$svg_file]}"
    if [ -z "$cursor_info" ]; then
        echo -e "${YELLOW}跳过未知文件：$svg_file${NC}"
        continue
    fi
    
    # Parse cursor names and hotspot
    IFS=':' read -r name1 name2 hotspot_x hotspot_y <<< "$cursor_info"
    
    echo -n "处理 $svg_file -> $name1, $name2 ... "
    
    # Create temporary PNG
    temp_png=$(mktemp --suffix=.png)
    
    # Convert SVG to PNG (32px for standard cursors)
    if convert_cursor "$svg_file" "$temp_png" 32; then
        # Create cursor files with hotspot
        if [ "$TOOLS_AVAILABLE" = true ] && command -v xcursorgen &> /dev/null; then
            # Use xcursorgen for proper cursor format
            for cursor_name in $name1 $name2; do
                temp_config=$(mktemp)
                echo "$hotspot_x $hotspot_y $temp_png $CURSORS_SUBDIR/$cursor_name" > "$temp_config"
                xcursorgen -n "$temp_config" "$CURSORS_SUBDIR" 2>/dev/null
                rm -f "$temp_config"
            done
        else
            # Simplified: just copy PNG files
            for cursor_name in $name1 $name2; do
                cp "$temp_png" "$CURSORS_SUBDIR/$cursor_name"
            done
        fi
        
        rm -f "$temp_png"
        echo -e "${GREEN}✓ 完成${NC}"
        SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
    else
        rm -f "$temp_png"
        echo -e "${RED}✗ 失败${NC}"
    fi
done

echo ""
echo "转换完成：$SUCCESS_COUNT / $TOTAL_COUNT 成功"
echo ""

# Create index.theme file
echo -e "${BLUE}创建主题配置文件...${NC}"
cat > "$TARGET_DIR/index.theme" << EOF
[Icon Theme]
Name=Blue Archive
Name_zh_CN=蔚蓝档案
Comment=Blue Archive Style Mouse Cursors
Comment_zh_CN=蔚蓝档案风格鼠标指针
Inherits=default
CursorTheme=BlueArchive
EOF

if [ "$INSTALL_MODE" = "system" ]; then
    sudo chown -R root:root "$SYSTEM_CURSOR_DIR"
    sudo chmod -R 755 "$SYSTEM_CURSOR_DIR"
fi

echo -e "${GREEN}✓ 主题配置已创建${NC}"
echo ""

# Try to activate the cursor theme
echo -e "${BLUE}尝试激活主题...${NC}"

ACTIVATED=false

# Method 1: Using gsettings (GNOME)
if command -v gsettings &> /dev/null; then
    if gsettings set org.gnome.desktop.interface cursor-theme "$CURSOR_THEME_NAME" 2>/dev/null; then
        echo -e "${GREEN}✓ 已通过 gsettings 激活 (GNOME)${NC}"
        ACTIVATED=true
    fi
fi

# Method 2: Update alternatives (Debian/Ubuntu)
if [ "$INSTALL_MODE" = "system" ] && command -v update-alternatives &> /dev/null; then
    if sudo update-alternatives --install /usr/share/icons/default/index.theme x-cursor-theme "$SYSTEM_CURSOR_DIR/index.theme" 100 2>/dev/null; then
        sudo update-alternatives --set x-cursor-theme "$SYSTEM_CURSOR_DIR/index.theme" 2>/dev/null || true
        echo -e "${GREEN}✓ 已通过 update-alternatives 设置${NC}"
        ACTIVATED=true
    fi
fi

# Method 3: Create ~/.config/xsettings.conf
if [ "$ACTIVATED" = false ]; then
    mkdir -p "$HOME/.config"
    echo "Net/CursorTheme \"$CURSOR_THEME_NAME\"" > "$HOME/.config/xsettings.conf"
    echo -e "${YELLOW}! 已创建 ~/.config/xsettings.conf${NC}"
    echo "  可能需要重启或重新登录以应用更改"
fi

echo ""
echo "========================================================"
echo -e "${GREEN}安装完成！${NC}"
echo ""
echo "主题名称：Blue Archive (蔚蓝档案)"
echo "安装位置：$TARGET_DIR"
echo ""

if [ "$ACTIVATED" = false ]; then
    echo -e "${YELLOW}手动激活方法:${NC}"
    echo "  1. 打开系统设置 -> 外观/主题"
    echo "  2. 选择 'Blue Archive' 或 '蔚蓝档案' 作为指针主题"
    echo "  3. 或者使用工具如 gnome-tweaks, lxappearance 等"
    echo ""
    echo "  命令行方式 (如果支持):"
    echo "    gsettings set org.gnome.desktop.interface cursor-theme $CURSOR_THEME_NAME"
fi

echo ""
echo "如需卸载，运行:"
if [ "$INSTALL_MODE" = "system" ]; then
    echo "  sudo rm -rf $SYSTEM_CURSOR_DIR"
else
    echo "  rm -rf $CURSOR_THEME_DIR"
fi

echo "========================================================"
echo ""
echo -e "${BLUE}享受您的蔚蓝档案风格鼠标指针吧！${NC}"
echo "Enjoy your Blue Archive style cursors!"
echo ""
