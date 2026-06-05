const encryptKeyBuf = Buffer.from(ENCRYPTION_KEY, 'base64')
if (encryptKeyBuf.length !== 32) {
    throw new BadGatewayException(
        'ENCRYPTION_KEY must be 32 bytes (256-bit) for AES-256')
}
