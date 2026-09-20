#!/usr/bin/env python3
"""
Blue Archive Cursor Preview Generator
蔚蓝档案鼠标指针预览图生成器

This script generates preview images for all Blue Archive style cursors.
此脚本为所有蔚蓝档案风格鼠标指针生成预览图片。
"""

import cairosvg
import os
from PIL import Image, ImageDraw, ImageFont

# Cursor files and their descriptions
CURSORS = {
    'blue_archive_cursor_normal.svg': '正常选择 (Normal Select)',
    'blue_archive_cursor_link.svg': '链接选择 (Link Select)',
    'blue_archive_cursor_text.svg': '文本选择 (Text Select)',
    'blue_archive_cursor_precision.svg': '精确选择 (Precision Select)',
    'blue_archive_cursor_wait.svg': '忙碌等待 (Wait/Busy)',
    'blue_archive_cursor_busy.svg': '后台工作 (Background Work)',
    'blue_archive_cursor_help.svg': '帮助提示 (Help)',
    'blue_archive_cursor_unavailable.svg': '不可用 (Unavailable)',
    'blue_archive_cursor_vertical_resize.svg': '垂直调整 (Vertical Resize)',
    'blue_archive_cursor_horizontal_resize.svg': '水平调整 (Horizontal Resize)',
    'blue_archive_cursor_diagonal_resize.svg': '对角线调整 (Diagonal Resize)',
    'blue_archive_cursor_move.svg': '移动操作 (Move)',
}

def generate_preview(svg_file, output_png, size=128):
    """Convert SVG to PNG preview image"""
    try:
        # Convert SVG to PNG using cairosvg
        cairosvg.svg2png(
            url=svg_file,
            write_to=output_png,
            output_width=size,
            output_height=size
        )
        print(f"✓ 已生成：{output_png}")
        return True
    except Exception as e:
        print(f"✗ 生成失败 {output_png}: {e}")
        return False

def create_composite_preview(output_file='blue_archive_cursors_preview.png'):
    """Create a composite preview image showing all cursors"""
    preview_files = []
    
    # Generate individual previews
    for svg_file in CURSORS.keys():
        if os.path.exists(svg_file):
            png_file = svg_file.replace('.svg', '_preview.png')
            if generate_preview(svg_file, png_file, size=256):
                preview_files.append((svg_file, png_file))
    
    if not preview_files:
        print("错误：未找到任何 SVG 文件")
        return False
    
    # Create composite image
    cols = 4
    rows = (len(preview_files) + cols - 1) // cols
    cell_size = 280
    padding = 20
    
    width = cols * cell_size + padding * 2
    height = rows * cell_size + padding * 2 + 60  # Extra space for title
    
    # Create white background
    composite = Image.new('RGB', (width, height), (240, 248, 255))
    draw = ImageDraw.Draw(composite)
    
    # Try to load a font
    try:
        font = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf", 16)
        title_font = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf", 24)
    except:
        font = ImageFont.load_default()
        title_font = font
    
    # Draw title
    title = "Blue Archive Style Cursors - 蔚蓝档案风格鼠标指针"
    bbox = draw.textbbox((0, 0), title, font=title_font)
    title_width = bbox[2] - bbox[0]
    draw.text(((width - title_width) // 2, 20), title, fill=(0, 119, 182), font=title_font)
    
    # Draw subtitle
    subtitle = "Click to install with install.sh | 使用 install.sh 一键安装"
    bbox = draw.textbbox((0, 0), subtitle, font=font)
    subtitle_width = bbox[2] - bbox[0]
    draw.text(((width - subtitle_width) // 2, 50), subtitle, fill=(100, 100, 100), font=font)
    
    # Place each cursor preview
    for idx, (svg_file, png_file) in enumerate(preview_files):
        row = idx // cols
        col = idx % cols
        
        x = padding + col * cell_size
        y = padding + 60 + row * cell_size
        
        # Load and paste the preview
        try:
            cursor_img = Image.open(png_file)
            # Center the image in the cell
            img_x = x + (cell_size - 256) // 2
            img_y = y + (cell_size - 256) // 2
            if img_x < padding:
                img_x = padding
            if img_y < 80:
                img_y = 80
            composite.paste(cursor_img, (img_x, img_y), cursor_img.convert('RGBA'))
        except Exception as e:
            print(f"粘贴图像失败：{e}")
        
        # Draw label
        label = CURSORS[svg_file]
        bbox = draw.textbbox((0, 0), label, font=font)
        label_width = bbox[2] - bbox[0]
        label_x = x + (cell_size - label_width) // 2
        draw.text((label_x, y + 260), label, fill=(0, 0, 0), font=font)
    
    # Save composite image
    composite.save(output_file, 'PNG')
    print(f"\n✓ 已生成组合预览图：{output_file}")
    print(f"  尺寸：{width}x{height} 像素")
    print(f"  包含 {len(preview_files)} 个指针预览")
    
    return True

if __name__ == '__main__':
    print("=" * 60)
    print("Blue Archive Cursor Preview Generator")
    print("蔚蓝档案鼠标指针预览图生成器")
    print("=" * 60)
    print()
    
    success = create_composite_preview()
    
    if success:
        print("\n" + "=" * 60)
        print("生成完成！预览文件:")
        print("  - blue_archive_cursors_preview.png (组合预览图)")
        print("  - *_preview.png (单个指针预览)")
        print("=" * 60)
    else:
        print("\n生成失败，请检查是否有 SVG 文件")
        exit(1)
