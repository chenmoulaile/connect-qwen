# 蔚蓝档案风格鼠标指针 - 快速使用指南
# Blue Archive Style Cursors - Quick Start Guide

## 📦 文件说明 / Files Included

### 核心文件 / Core Files
- **12 个 SVG 指针文件** (`blue_archive_cursor_*.svg`) - 原始矢量指针设计
- **install.sh** - Linux 一键安装脚本
- **generate_preview.py** - 预览图生成脚本（已运行）

### 预览图片 / Preview Images
- **blue_archive_cursors_preview.png** (1160x940) - 包含所有 12 个指针的组合预览图
- **`*_preview.png`** - 每个指针的单独预览图 (256x256)

## 🎨 指针列表 / Cursor List

| 指针名称 | 功能 | 设计特点 |
|---------|------|---------|
| normal.svg | 正常选择 | 带光环 tip 的标准箭头 |
| link.svg | 链接选择 | 增强的光环和星光效果 |
| text.svg | 文本选择 | I 型光束光标 |
| precision.svg | 精确选择 | 带光环中心的十字准星 |
| wait.svg | 忙碌等待 | 旋转加载指示器 |
| busy.svg | 后台工作 | 带进度指示的箭头 |
| help.svg | 帮助提示 | 带问号叠加的箭头 |
| unavailable.svg | 不可用 | 淡化的禁止符号 |
| vertical_resize.svg | 垂直调整 | 双向垂直箭头 |
| horizontal_resize.svg | 水平调整 | 双向水平箭头 |
| diagonal_resize.svg | 对角线调整 | 斜向双向箭头 |
| move.svg | 移动操作 | 四向箭头十字 |

## 🚀 快速安装 / Quick Install

### Linux 用户
```bash
# 用户级安装（推荐，无需 root）
./install.sh

# 或系统级安装（需要 sudo）
sudo ./install.sh
```

安装脚本会自动：
1. ✅ 将 SVG 转换为 PNG 格式
2. ✅ 创建正确的目录结构
3. ✅ 生成 cursor 格式文件
4. ✅ 尝试自动激活主题

### 手动安装其他系统

**Windows:**
1. 使用 Cursor Editor 等工具将 SVG 转为 .cur/.ani 格式
2. 设置 > 个性化 > 主题 > 鼠标指针
3. 为每种指针类型选择转换后的文件

**macOS:**
1. 使用鼠标指针转换工具
2. 系统偏好设置 > 辅助功能 > 显示 > 指针

## 🖼️ 查看预览 / View Previews

预览图已生成在：
- 组合预览：`blue_archive_cursors_preview.png`
- 单个预览：`*_preview.png` 文件

如需重新生成预览：
```bash
python3 generate_preview.py
```

## 🎨 设计特色 / Design Features

- ✨ **光环元素** - 每个指针都有蔚蓝档案标志性的光环装饰
- 💙 **蓝白配色** - 使用 #00a8e8 和 #0077b6 的经典蓝色
- ⭐ **星光点缀** - 金色 (#ffd700) 星光增加魔法感
- 🔆 **发光效果** - 柔和的发光滤镜创造深度感

## ⚙️ 自定义 / Customization

编辑 SVG 文件可轻松自定义：

### 修改颜色
```xml
<linearGradient id="blueAccent">
  <stop offset="0%" style="stop-color:#YOUR_COLOR"/>
  <stop offset="100%" style="stop-color:#YOUR_COLOR"/>
</linearGradient>
```

### 调整大小
修改根 `<svg>` 元素的 `width`, `height`, `viewBox` 属性。

### 效果强度
调整模糊滤镜中的 `stdDeviation` 值或 `opacity` 值。

## ❌ 卸载 / Uninstall

```bash
# 用户级安装
rm -rf ~/.icons/BlueArchive

# 系统级安装
sudo rm -rf /usr/share/icons/BlueArchive
```

## 📝 注意事项 / Notes

- 本指针套装为粉丝艺术作品，与 Nexon Games 无关
- SVG 格式可无限缩放而不失真
- 建议在不同背景下测试指针可见性
- 如需动画指针，需使用专业工具转换

## 🔗 相关链接 / Links

- 详细说明：README_CURSORS.md
- 预览图：blue_archive_cursors_preview.png
- 源文件：blue_archive_cursor_*.svg

---

**享受您的蔚蓝档案风格鼠标指针！**  
Enjoy your Blue Archive style cursors! ✨
