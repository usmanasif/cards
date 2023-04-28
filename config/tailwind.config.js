const defaultTheme = require('tailwindcss/defaultTheme')
const colors = {
  black: {
    DEFAULT: '#000000',
    light: ' #020A1A'
  },
  blue: {
    dark: '#1A202C',
    royal: '#6B63E8'
  },
  red: {
    DEFAULT: '#FF2950',
    light: '#FEB3C1',
    lighter: '#EB8F7A',
    ultralight: '#FBF2F0',
    dark: '#CF2763'
  },
  cyan: {
    DEFAULT: '#12C0DB'
  },
  green: {
    DEFAULT: '#55BC8E',
    light: '#3EC28F',
    dark: '#127A5B',
    bright: '#2CCC71'
  },
  white: '#FFFFFF',
  grey: {
    DEFAULT: '#757575',
    dark: '#6D6D6D',
    light: '#DADADA',
    ultralight: '#E4E4E4',
    dim: '#6C6C6C'
  },
  transparent: 'transparent'
}

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
