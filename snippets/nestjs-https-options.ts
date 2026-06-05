const httpsOptions = {
    key:  readFileSync('certs/server.key'),
    cert: readFileSync('certs/server.crt')
}
const app = await NestFactory.create(AppModule, { httpsOptions })
