module.exports = {
  testEnvironment: "jsdom",
  setupFilesAfterEnv: ["<rootDir>/jest.setup.js"],
  moduleDirectories: ["node_modules", "app/javascript"],
  testMatch: [
    "**/__tests__/**/*.test.[jt]s?(x)"
  ],
  transform: {
    "^.+\\.[t|j]sx?$": "babel-jest"
  },
  moduleNameMapper: {
    "\\.(css|less|scss|sass)$": "identity-obj-proxy"
  },
  resolver: undefined
} 