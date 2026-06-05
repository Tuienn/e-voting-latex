// Redis key: session:signed:{voterId}    TTL: 120 s (REDIS_SESSION_CACHE_TTL)
interface VotingSession {
    sessionId:     string   // UUID v4
    signed:        boolean
    electionId:    string
    signatureHex?: string   // có sau khi ký mù hoàn thành
    voted:         boolean
}
