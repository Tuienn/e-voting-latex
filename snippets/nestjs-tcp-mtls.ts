app.connectMicroservice<MicroserviceOptions>({
    transport: Transport.TCP,
    options: {
        host, port,
        tlsOptions: {
            key:  readFileSync('service.key'),
            cert: readFileSync('service.cert'),
            ca:   readFileSync('ca.cert'),
            requestCert: true   // mTLS: yêu cầu client cert
        }
    }
})
