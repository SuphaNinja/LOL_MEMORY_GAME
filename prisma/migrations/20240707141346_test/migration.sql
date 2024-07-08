-- CreateTable
CREATE TABLE "Follow" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "followingId" TEXT NOT NULL,
    "followedId" TEXT NOT NULL,
    CONSTRAINT "Follow_followingId_fkey" FOREIGN KEY ("followingId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "Follow_followedId_fkey" FOREIGN KEY ("followedId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "MemoryCards" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "image" TEXT,
    "title" TEXT,
    "isVisible" BOOLEAN NOT NULL DEFAULT false
);

-- CreateTable
CREATE TABLE "GameSession" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "currentTurn" INTEGER NOT NULL DEFAULT 0,
    "status" TEXT NOT NULL DEFAULT 'pending',
    "currentTime" INTEGER DEFAULT 30
);

-- CreateTable
CREATE TABLE "GameCard" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "gameSessionId" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "image" TEXT NOT NULL,
    "memoryCardId" TEXT NOT NULL,
    "isMatched" BOOLEAN NOT NULL DEFAULT false,
    "isVisible" BOOLEAN NOT NULL DEFAULT false,
    "position" INTEGER NOT NULL,
    "foundById" TEXT,
    CONSTRAINT "GameCard_gameSessionId_fkey" FOREIGN KEY ("gameSessionId") REFERENCES "GameSession" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "GameCard_memoryCardId_fkey" FOREIGN KEY ("memoryCardId") REFERENCES "MemoryCards" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "GameCard_foundById_fkey" FOREIGN KEY ("foundById") REFERENCES "Player" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Player" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "gameSessionId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "points" INTEGER NOT NULL DEFAULT 0,
    CONSTRAINT "Player_gameSessionId_fkey" FOREIGN KEY ("gameSessionId") REFERENCES "GameSession" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "Player_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateIndex
CREATE INDEX "GameSession_createdAt_idx" ON "GameSession"("createdAt");

-- CreateIndex
CREATE INDEX "GameCard_gameSessionId_idx" ON "GameCard"("gameSessionId");

-- CreateIndex
CREATE UNIQUE INDEX "GameCard_gameSessionId_memoryCardId_key" ON "GameCard"("gameSessionId", "memoryCardId");
