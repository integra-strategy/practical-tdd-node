module.exports = {
  // Really weird bug. Not sure why this is happening, but the following line fixes it: https://github.com/jest-community/vscode-jest/issues/382#issuecomment-424083512
  modulePaths: ["<rootDir>"],
  testEnvironment: "node",
  setupFilesAfterEnv: ["<rootDir>/setupFilesAfterEnv.js"]
}
