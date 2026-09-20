# Blue Archive Style Mouse Cursor Set
# 蔚蓝档案风格鼠标指针套装

## Overview / 概述

A complete set of mouse cursors inspired by the popular game **Blue Archive** (蔚蓝档案). 
This cursor set features the iconic halo rings, blue and white color scheme, and sparkling star effects that are characteristic of the game's aesthetic.

一套受热门游戏**蔚蓝档案**启发的完整鼠标指针套装。这套指针以游戏中标志性的光环元素、蓝白配色方案和闪耀的星光效果为特色。

## Design Elements / 设计元素

- **Halo Rings** (光环): Each cursor features decorative halo rings reminiscent of the characters' halos in Blue Archive
- **Blue & White Color Scheme** (蓝白配色): Clean, modern aesthetic using shades of blue (#00a8e8, #0077b6) and white
- **Sparkle Effects** (星光点缀): Golden sparkle accents (#ffd700) add a magical touch
- **Glow Effects** (发光效果): Soft glow filters create depth and visual interest

## Included Cursors / 包含的指针

| File Name | Cursor Type | Description |
|-----------|-------------|-------------|
| `blue_archive_cursor_normal.svg` | Normal Select | Standard arrow pointer with halo tip |
| `blue_archive_cursor_link.svg` | Link Select | Enhanced halo and sparkles for clickable links |
| `blue_archive_cursor_text.svg` | Text Select (I-Beam) | I-beam cursor for text selection |
| `blue_archive_cursor_busy.svg` | Busy/Wait | Circular loading indicator with rotating segments |
| `blue_archive_cursor_precision.svg` | Precision Select | Crosshair with halo center for precise tasks |
| `blue_archive_cursor_help.svg` | Help | Arrow with question mark overlay |
| `blue_archive_cursor_wait.svg` | Work in Background | Arrow with small progress indicator |
| `blue_archive_cursor_unavailable.svg` | Unavailable | Faded arrow with prohibition symbol |
| `blue_archive_cursor_vertical_resize.svg` | Vertical Resize (NS) | Double-headed vertical arrow |
| `blue_archive_cursor_horizontal_resize.svg` | Horizontal Resize (WE) | Double-headed horizontal arrow |
| `blue_archive_cursor_diagonal_resize.svg` | Diagonal Resize (NESW) | Diagonal double-headed arrow |
| `blue_archive_cursor_move.svg` | Move (All Directions) | Four-directional arrow cross |

## File Format / 文件格式

All cursors are provided in **SVG (Scalable Vector Graphics)** format, which offers:
- Infinite scalability without quality loss
- Easy customization of colors and effects
- Small file sizes
- Wide compatibility with modern systems

所有指针均以 **SVG（可缩放矢量图形）** 格式提供，具有以下优点：
- 无限缩放而不损失质量
- 轻松自定义颜色和效果
- 文件体积小
- 与现代系统广泛兼容

## Installation / 安装

### Quick Install (Linux) / 快速安装 (Linux)

Simply run the installation script:
只需运行安装脚本：

```bash
./install.sh
# Or for system-wide installation / 或系统级安装
sudo ./install.sh
```

The script will:
- Convert SVG files to the appropriate cursor format
- Install them to your user or system directory
- Attempt to activate the theme automatically

脚本将自动：
- 将 SVG 文件转换为适当的指针格式
- 安装到用户或系统目录
- 尝试自动激活主题

### Manual Install / 手动安装

#### Windows
1. Convert SVG files to `.cur` or `.ani` format using a cursor editor tool
2. Open Settings > Personalization > Themes > Mouse Cursor
3. Browse and select the converted cursor files for each cursor type
4. Save as a new theme

#### macOS
1. Use a cursor conversion tool to convert SVG to `.cursor` format
2. Open System Preferences > Accessibility > Display > Pointer
3. Apply the custom cursor theme

#### Linux
1. Create a cursor theme directory structure: `~/.icons/BlueArchive/cursors/`
2. Convert SVG files to PNG format at multiple sizes (24x24, 32x32, 48x48)
3. Use `xcursorgen` to generate cursor files
4. Apply using your desktop environment's settings or `gsettings`

## Customization / 自定义

You can easily customize the cursors by editing the SVG files:

### Color Changes
Modify the gradient definitions in the `<defs>` section:
```xml
<linearGradient id="blueAccent">
  <stop offset="0%" style="stop-color:#YOUR_COLOR"/>
  <stop offset="100%" style="stop-color:#YOUR_COLOR"/>
</linearGradient>
```

### Size Adjustments
Change the `width`, `height`, and `viewBox` attributes in the root `<svg>` element.

### Effect Intensity
Adjust the `stdDeviation` value in the blur filter or opacity values.

## License / 许可证

This cursor set is created as fan art inspired by Blue Archive. 
Blue Archive is a trademark of Nexon Games. This project is not affiliated with or endorsed by Nexon Games.

本指针套装是受蔚蓝档案启发的粉丝艺术作品。
Blue Archive 是 Nexon Games 的商标。本项目与 Nexon Games 无关，也未获得其认可。

## Credits / 制作信息

Created with ❤️ for Blue Archive fans worldwide.
为全世界的蔚蓝档案粉丝用心制作。

---

**Version:** 1.0  
**Date:** 2024  
**Format:** SVG (64x64px viewBox)
