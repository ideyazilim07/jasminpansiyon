/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{js,ts,jsx,tsx}'],
  theme: {
    extend: {
      colors: {
        gold: {
          50:  '#FFF8E7',
          100: '#FFEFC5',
          200: '#FFD980',
          300: '#FFC03A',
          400: '#FFAD0D',
          500: '#C9A84C',
          600: '#A08030',
          700: '#7A6020',
        },
      },
      fontFamily: {
        sans: ['Inter', 'system-ui', 'sans-serif'],
      },
    },
  },
  plugins: [],
}
