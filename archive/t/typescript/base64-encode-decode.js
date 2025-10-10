function usageAndExit() {
    console.log("Usage: please provide a mode and a string to encode/decode");
    process.exit(1);
}
/**
 * Validates if a string is valid base64 format
 * @param str the string to validate
 * @returns true if valid base64, false otherwise
 */
function isValidBase64(str) {
    // Check length is multiple of 4
    if (str.length % 4 !== 0) {
        return false;
    }
    // Only A-Z, a-z, 0-9, +, /, = allowed
    if (!/^[A-Za-z0-9+/]*={0,2}$/.test(str)) {
        return false;
    }
    // = only allowed at end, at most two
    var idx = str.indexOf("=");
    if (idx !== -1 && idx < str.length - 2) {
        // e.g. "ab==cd" is invalid
        return false;
    }
    return true;
}
/**
 * Encodes a string to base64
 * @param input the string to encode
 * @returns base64 encoded string
 */
function encodeBase64(input) {
    // Use Buffer in Node.js
    return Buffer.from(input, "ascii").toString("base64");
}
/**
 * Decodes a base64 string
 * @param input the base64 string to decode
 * @returns decoded string
 */
function decodeBase64(input) {
    // Validate first
    if (!isValidBase64(input)) {
        usageAndExit();
    }
    // Buffer will decode the base64 string
    return Buffer.from(input, "base64").toString("ascii");
}
/**
 * Main function to process command line arguments
 */
function main() {
    var args = process.argv.slice(2);
    if (args.length < 2) {
        usageAndExit();
    }
    var mode = args[0];
    var text = args[1];
    if (!text) {
        usageAndExit();
    }
    if (mode === "encode") {
        console.log(encodeBase64(text));
    }
    else if (mode === "decode") {
        console.log(decodeBase64(text));
    }
    else {
        usageAndExit();
    }
}
// Execute main function
main();
