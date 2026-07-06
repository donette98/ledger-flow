# Ledger Flow - Design System

## 🎨 Color Palette

### Primary Colors
- **Primary Brand**: `#6366F1` (Indigo)
- **Secondary**: `#8B5CF6` (Violet)
- **Accent**: `#EC4899` (Pink)

### Neutral Colors
- **Background**: `#FFFFFF` (White)
- **Surface**: `#F9FAFB` (Light Gray)
- **Border**: `#E5E7EB` (Gray)
- **Text Primary**: `#1F2937` (Dark Gray)
- **Text Secondary**: `#6B7280` (Medium Gray)
- **Text Tertiary**: `#9CA3AF` (Light Gray)

### Status Colors
- **Success**: `#10B981` (Emerald)
- **Warning**: `#F59E0B` (Amber)
- **Error**: `#EF4444` (Red)
- **Info**: `#3B82F6` (Blue)

## 🔤 Typography

### Font Family
- **Primary**: Inter, -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif
- **Alternative**: 'Poppins', sans-serif (rounded sans-serif for headers)

### Font Sizes
- **Display Large**: 36px (H1)
- **Display Medium**: 28px (H2)
- **Display Small**: 24px (H3)
- **Title Large**: 20px (H4)
- **Title Medium**: 16px (H5)
- **Body Large**: 16px (default)
- **Body Medium**: 14px
- **Body Small**: 12px
- **Label Large**: 14px (bold)
- **Label Medium**: 12px (bold)

### Font Weights
- **Light**: 300
- **Regular**: 400
- **Medium**: 500
- **Semibold**: 600
- **Bold**: 700

## 🎭 Spacing System

```
4px   - xs
8px   - sm
12px  - md
16px  - lg
20px  - xl
24px  - 2xl
32px  - 3xl
40px  - 4xl
48px  - 5xl
```

## 🔲 Components Style Guide

### Buttons

#### Elevated Button (Primary)
- Background: `#6366F1`
- Text Color: White
- Padding: 12px 24px
- Border Radius: 8px
- Font Weight: 600
- Hover State: Lift effect (translateY: -2px), shadow increase, opacity 0.9
- Transition: 200ms cubic-bezier(0.4, 0, 0.2, 1)

#### Outlined Button (Secondary)
- Background: Transparent
- Border: 1px `#E5E7EB`
- Text Color: `#1F2937`
- Padding: 12px 24px
- Border Radius: 8px
- Hover State: Background `#F9FAFB`, border color `#D1D5DB`

#### Ghost Button (Tertiary)
- Background: Transparent
- Text Color: `#6366F1`
- Padding: 12px 24px
- Hover State: Background `#F3F4F6`

### Cards
- Background: White
- Border Radius: 12px
- Padding: 16px
- Box Shadow: `0 1px 3px rgba(0,0,0,0.1), 0 1px 2px rgba(0,0,0,0.06)`
- Hover Shadow: `0 10px 15px rgba(0,0,0,0.1), 0 4px 6px rgba(0,0,0,0.05)`
- Transition: 300ms ease

### Input Fields
- Background: White
- Border: 1px `#E5E7EB`
- Border Radius: 8px
- Padding: 10px 12px
- Focus State: Border color `#6366F1`, box-shadow with primary color
- Font Size: 16px
- Transition: 150ms ease

### Tags/Badges
- Border Radius: 12px
- Padding: 4px 8px (small), 6px 12px (medium)
- Font Weight: 500
- Font Size: 12px (small), 14px (medium)

## 🌊 Shadows

### Shadow Levels
```
sm: 0 1px 2px 0 rgba(0,0,0,0.05)
md: 0 4px 6px -1px rgba(0,0,0,0.1)
lg: 0 10px 15px -3px rgba(0,0,0,0.1)
xl: 0 20px 25px -5px rgba(0,0,0,0.1)
2xl: 0 25px 50px -12px rgba(0,0,0,0.25)
```

## 🎬 Animations & Transitions

### Standard Timing Functions
- **Fast**: 150ms
- **Base**: 200ms
- **Slow**: 300ms
- **Very Slow**: 500ms

### Easing Functions
- **Ease In**: cubic-bezier(0.4, 0, 1, 1)
- **Ease Out**: cubic-bezier(0, 0, 0.2, 1)
- **Ease In Out**: cubic-bezier(0.4, 0, 0.2, 1)

### Common Animations
- **Fade In/Out**: opacity transition, 200ms
- **Slide Up**: transform: translateY, 300ms
- **Scale**: transform: scale, 200ms
- **Button Hover Lift**: translateY: -2px, 200ms

## 📏 Breakpoints

- **Mobile**: 0px - 640px
- **Tablet**: 641px - 1024px
- **Desktop**: 1025px+

## ✨ Dark Mode (Future)

When implemented, invert colors while maintaining contrast ratios:
- Background: `#0F172A`
- Surface: `#1E293B`
- Text Primary: `#F1F5F9`
- Borders: `#334155`

## 🎯 Accessibility

- **Minimum Contrast Ratio**: WCAG AA (4.5:1 for text)
- **Focus States**: Always visible with 2px outline in primary color
- **Touch Targets**: Minimum 44x44px
- **Font Sizes**: Minimum 14px for body text
- **Line Height**: 1.5 for body text