
# 📘 API Reference: Swagger-Generated Endpoints

This document provides an overview of the REST API endpoints available in the TM8 app via the Swagger client.

---

## 🔐 Authentication

- `POST /api/v1/auth/sign-in`
- `POST /api/v1/auth/register`
- `POST /api/v1/auth/token/refresh`
- `POST /api/v1/auth/google/verify`
- `POST /api/v1/auth/apple/verify`
- `POST /api/v1/auth/forgot-password/reset`
- `PATCH /api/v1/auth/set-phone-number`
- `POST /api/v1/auth/verify-phone`

## 👤 User & Profile Management

- `GET /api/v1/users`
- `GET /api/v1/users/me`
- `GET /api/v1/users/search`
- `GET /api/v1/users/friends`
- `GET /api/v1/users/blocks`
- `GET /api/v1/users/{userId}/profile`
- `GET /api/v1/users/{userId}/preferences`
- `PATCH /api/v1/users/image`
- `PATCH /api/v1/users/audio-intro`
- `GET /api/v1/users/{userId}/friend-check`
- `GET /api/v1/users/{userId}/block-check`
- `GET /api/v1/users/{userId}/games`

## 🔔 Notifications

- `GET /api/v1/notifications/unread-count`
- `GET /api/v1/notifications`
- `GET /api/v1/scheduled-notifications`
- `POST /api/v1/scheduled-notifications`
- `PATCH /api/v1/scheduled-notifications/{notificationId}`

## 🎮 Games

- `GET /api/v1/games`
- `GET /api/v1/games/game-preference-form`
- `GET /api/v1/users/{userId}/games`

## 🔄 Matchmaking

- `GET /api/v1/matchmaking/game-results`
- `POST /api/v1/matchmaking/game-accept`
- `GET /api/v1/matches/check/{userId}`
- `GET /api/v1/matches/feedback/users/{userId}/check`

## 💬 Chat

- `POST /api/v1/chat/channel`
- `GET /api/v1/chat/user-channels`
- `POST /api/v1/chat/token/refresh`

## 📊 Statistics

- `GET /api/v1/statistics/users/total-count`
- `GET /api/v1/statistics/users/new-users-registered`
- `GET /api/v1/statistics/users/onboarding-completion`
- `GET /api/v1/statistics/users/group-counts`

---

> ℹ️ These endpoints are auto-generated and used internally by Chopper. Their implementation resides in the backend server, not in the Flutter app.
