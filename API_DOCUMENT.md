# Wardrobe Backend API Documentation

**Version**: 1.0.0-mvp
**Base URL**: `http://localhost:5001`
**Content-Type**: `application/json` (except file uploads)

---

## Overview

The Wardrobe Backend API provides endpoints for:
- Garment image segmentation and analysis
- Outfit suggestion based on wardrobe metadata
- Virtual try-on compositing (low-res and high-res)
- User feedback collection

**Architecture**: Local-first MVP - all images are ephemeral and deleted after processing. No persistent cloud storage.

---

## Authentication

**MVP**: The system uses a Dual Token Strategy (JWT Access Token + Persistent Refresh Token). See `AUTH_GUIDE.md` for full implementation details and client-side integration guidelines.

### Register

#### `POST /api/v1/register`

Register a new user.

**Rate Limit**: 5 requests per minute

**Request** (application/json):
```json
{
  "email": "user@example.com",
  "password": "securePassword123"
}
```

**Response** (201 Created):
```json
{
  "message": "User registered successfully",
  "user": {
    "id": 1,
    "email": "user@example.com",
    "created_at": "2024-12-07T10:00:00Z",
    "is_active": true
  }
}
```

**Errors**:
- `400 Bad Request` - Missing email or password
- `409 Conflict` - Email already registered
- `500 Internal Server Error` - Database error

### Login

#### `POST /api/v1/login`

Authenticate user and receive access and refresh tokens.

**Rate Limit**: 10 requests per minute

**Request** (application/json):
```json
{
  "email": "user@example.com",
  "password": "securePassword123"
}
```

**Response** (200 OK):
```json
{
  "access_token": "ey...",
  "expires_in": 900,
  "refresh_token": "def...",
  "refresh_expires_in": 2592000,
  "token_type": "Bearer"
}
```

**Errors**:
- `400 Bad Request` - Missing email or password
- `401 Unauthorized` - Invalid credentials

### Refresh Token

#### `POST /api/v1/token/refresh`

Obtain a new access token using a valid refresh token. Rotates the refresh token (returns a new one).

**Rate Limit**: 20 requests per minute

**Request** (application/json):
```json
{
  "refresh_token": "def..."
}
```

**Response** (200 OK):
```json
{
  "access_token": "ey...",
  "expires_in": 900,
  "refresh_token": "new_def...",
  "refresh_expires_in": 2592000,
  "token_type": "Bearer"
}
```

**Errors**:
- `400 Bad Request` - Missing refresh token
- `401 Unauthorized` - Invalid or expired refresh token

### Get Current User

#### `GET /api/v1/me`

Get profile information for the current authenticated user.

**Header**: `Authorization: Bearer <access_token>`

**Response** (200 OK):
```json
{
  "id": 1,
  "email": "user@example.com",
  "created_at": "2024-12-07T10:00:00Z",
  "is_active": true
}
```

### Logout

#### `POST /api/v1/logout`

Revoke the refresh token.

**Request** (application/json):
```json
{
  "refresh_token": "def..."
}
```

**Response** (200 OK):
```json
{
  "message": "Logged out successfully"
}
```

---

## Core Endpoints

### Health Check

#### `GET /health`

Check API health and configuration.

**Response** (200 OK):
```json
{
  "status": "healthy",
  "timestamp": "2024-12-07T10:00:00.000Z",
  "config": {
    "environment": "development",
    "rate_limit_enabled": true,
    "max_upload_size_mb": 3
  },
  "file_manager": {
    "tracked_files": 0,
    "oldest_age_seconds": 0,
    "temp_dir": "/tmp/wardrobe_temp",
    "ttl_minutes": 30
  }
}
```

---

## Garment Processing

### Segment Garment

#### `POST /process/segment`

Segment a garment image and extract metadata (colors, type).

**Request** (multipart/form-data):
```
image: <file>  (required) - Garment image (JPG, PNG, WEBP, max 3MB)
type_hint: <string> (optional) - Garment type hint ("top", "bottom", "shoes", etc.)
```

**cURL Example**:
```bash
curl -X POST http://localhost:5001/process/segment \
  -F "image=@shirt.jpg" \
  -F "type_hint=top"
```

**Response** (200 OK) - Phase 2 Implementation:
```json
{
  "mask_png": "base64_encoded_png_data...",
  "tags": {
    "colors": ["red", "white"],
    "color_hex": ["#FF0000", "#FFFFFF"],
    "garment_type": "top",
    "pattern": "solid"
  },
  "processing_time_ms": 1240
}
```

**Current Response** (501 Not Implemented - Phase 1):
```json
{
  "status": "not_implemented",
  "message": "Segmentation will be implemented in Phase 2",
  "type_hint": "top",
  "file_size": 245678,
  "mime_type": "image/jpeg"
}
```

**Errors**:
- `400 Bad Request` - No file provided or invalid file
- `413 Payload Too Large` - File exceeds max size
- `429 Too Many Requests` - Rate limit exceeded
- `500 Internal Server Error` - Processing failed

---

### Create Thumbnail

#### `POST /process/thumbnail`

Generate a thumbnail collage from multiple garment images.

**Request** (multipart/form-data):
```
images[]: <file>  (required, multiple) - 2-10 garment images
layout_hint: <string> (optional) - "grid_2x3", "grid_3x2", etc.
```

**cURL Example**:
```bash
curl -X POST http://localhost:5001/process/thumbnail \
  -F "images[]=@shirt1.jpg" \
  -F "images[]=@shirt2.jpg" \
  -F "images[]=@pants.jpg" \
  -F "images[]=@shoes.jpg"
```

**Response** (200 OK) - Phase 2 Implementation:
```json
{
  "thumbnail_png": "base64_encoded_png_data...",
  "grid_size": [2, 3],
  "item_count": 6,
  "processing_time_ms": 450
}
```

**Current Response** (501 Not Implemented):
```json
{
  "status": "not_implemented",
  "message": "Thumbnail generation will be implemented in Phase 2",
  "file_count": 4
}
```

---

## Outfit Suggestions

### Suggest Outfits

#### `POST /suggest`

Generate outfit combinations based on wardrobe item metadata.

**Request** (application/json):
```json
{
  "items": [
    {
      "id": "item_001",
      "garment_type": "top",
      "colors": ["red", "white"],
      "tags": ["casual", "summer"]
    },
    {
      "id": "item_002",
      "garment_type": "bottom",
      "colors": ["blue"],
      "tags": ["denim", "casual"]
    }
  ],
  "context": {
    "weather": "sunny",
    "occasion": "casual",
    "style_pref": "minimalist"
  },
  "limit": 3
}
```

**cURL Example**:
```bash
curl -X POST http://localhost:5001/suggest \
  -H "Content-Type: application/json" \
  -d '{
    "items": [
      {"id": "1", "garment_type": "top", "colors": ["red"]},
      {"id": "2", "garment_type": "bottom", "colors": ["blue"]}
    ],
    "context": {"occasion": "casual"},
    "limit": 3
  }'
```

**Response** (200 OK) - Phase 6 (Deferred):
```json
{
  "outfits": [
    {
      "items": ["item_001", "item_002", "item_003"],
      "score": 8.5,
      "reason_tags": [
        "color_harmony_complementary",
        "type_compatible",
        "occasion_match"
      ]
    }
  ]
}
```

**Current Response** (501 Not Implemented):
```json
{
  "status": "not_implemented",
  "message": "Outfit suggestion deferred to Phase 6 (post-MVP)",
  "received_items": 2
}
```

---

## Virtual Try-On

### Low-Res Try-On (Preview)

#### `POST /tryon/lowres`

Create a fast low-resolution composite preview (client-side manipulation).

**Request** (multipart/form-data):
```
selfie: <file> (required) - User selfie image
garment_images[]: <file> (required, multiple) - Garment images to composite
masks[]: <file> (optional, multiple) - Pre-generated masks for garments
transforms[]: <json> (optional) - Affine transformation matrices
```

**cURL Example**:
```bash
curl -X POST http://localhost:5001/tryon/lowres \
  -F "selfie=@selfie.jpg" \
  -F "garment_images[]=@shirt.jpg" \
  -F "garment_images[]=@pants.jpg" \
  -F "masks[]=@shirt_mask.png"
```

**Response** (200 OK) - Phase 3 Implementation:
```json
{
  "preview_png": "base64_encoded_png_data...",
  "quality_hint": "preview",
  "resolution": [720, 1280],
  "processing_time_ms": 2800
}
```

**Current Response** (501 Not Implemented):
```json
{
  "status": "not_implemented",
  "message": "Low-res try-on will be implemented in Phase 3"
}
```

---

### High-Res Try-On (Gemini API)

#### `POST /tryon/highres`

Create a high-resolution composite using Gemini generative API (async).

**Important**: This endpoint requires explicit user opt-in as it sends images to external Gemini API.

**Request** (multipart/form-data):
```
selfie: <file> (required) - User selfie
garment_images[]: <file> (required, multiple) - Garments to composite
prompt_params: <json> (optional) - Additional prompt parameters
```

**cURL Example**:
```bash
curl -X POST http://localhost:5001/tryon/highres \
  -F "selfie=@selfie.jpg" \
  -F "garment_images[]=@shirt.jpg" \
  -F "garment_images[]=@pants.jpg"
```

**Response** (202 Accepted) - Phase 4 Implementation:
```json
{
  "job_id": "job_abc123def456",
  "status": "processing",
  "estimated_time_seconds": 45
}
```

**Current Response** (501 Not Implemented):
```json
{
  "status": "not_implemented",
  "message": "High-res try-on will be implemented in Phase 4"
}
```

---

### Get Try-On Result

#### `GET /tryon/result/<job_id>`

Poll for high-res try-on job result.

**cURL Example**:
```bash
curl http://localhost:5001/tryon/result/job_abc123def456
```

**Response - Processing** (200 OK):
```json
{
  "job_id": "job_abc123def456",
  "status": "processing",
  "progress": 60,
  "message": "Generating composite..."
}
```

**Response - Completed** (200 OK):
```json
{
  "job_id": "job_abc123def456",
  "status": "completed",
  "result_png": "base64_encoded_png_data...",
  "resolution": [1080, 1920],
  "processing_time_ms": 42000
}
```

**Response - Failed** (200 OK):
```json
{
  "job_id": "job_abc123def456",
  "status": "failed",
  "error": "Gemini API timeout",
  "message": "Processing failed after 3 retries"
}
```

**Current Response** (501 Not Implemented):
```json
{
  "status": "not_implemented",
  "message": "Job polling will be implemented in Phase 4",
  "job_id": "job_abc123def456"
}
```

**Errors**:
- `404 Not Found` - Job ID not found or expired (TTL: 1 hour)

---

## Feedback

### Submit Feedback

#### `POST /feedback`

Submit user feedback for outfit suggestions or try-ons.

**Request** (application/json):
```json
{
  "type": "like" | "dislike",
  "context": {
    "outfit_ids": ["item_001", "item_002"],
    "reason": "Great color combination"
  }
}
```

**cURL Example**:
```bash
curl -X POST http://localhost:5001/feedback \
  -H "Content-Type: application/json" \
  -d '{
    "type": "like",
    "context": {"outfit_ids": ["1", "2"], "reason": "Perfect match"}
  }'
```

**Response** (200 OK):
```json
{
  "status": "ok"
}
```

**Errors**:
- `400 Bad Request` - Invalid feedback type or missing data

---

## File Upload Requirements

### Allowed Formats
- **Extensions**: `.jpg`, `.jpeg`, `.png`, `.webp`
- **MIME Types**: `image/jpeg`, `image/png`, `image/webp`

### File Size Limits
- **Default**: 3MB per file
- **Maximum Request Size**: 16MB total (for multiple files)
- **Configurable**: Set `MAX_UPLOAD_SIZE_MB` environment variable

### Validation
All uploaded files are validated for:
1. **Extension** - Must be in allowed list
2. **MIME Type** - Detected using python-magic (not just extension)
3. **File Size** - Within limits
4. **Path Traversal** - Filename sanitized

**Invalid File Response** (400 Bad Request):
```json
{
  "error": "Invalid file",
  "details": [
    "File too large: 4.2MB (max: 3MB)",
    "Invalid MIME type: application/pdf"
  ]
}
```

---

## Error Responses

### Standard Error Format

All errors follow this format:
```json
{
  "error": "<Error Type>",
  "message": "<Human-readable message>",
  "details": []  // Optional array of specific issues
}
```

### Common HTTP Status Codes

| Code | Meaning | Common Causes |
|------|---------|---------------|
| 200 | OK | Request successful |
| 202 | Accepted | Async job created |
| 400 | Bad Request | Invalid input, missing required fields |
| 404 | Not Found | Endpoint or resource doesn't exist |
| 413 | Payload Too Large | File(s) exceed size limit |
| 429 | Too Many Requests | Rate limit exceeded |
| 500 | Internal Server Error | Server-side processing error |
| 501 | Not Implemented | Feature not yet implemented (MVP) |

---

## Environment Configuration

### Required Variables
```bash
SECRET_KEY=<random-secret-key>  # Required in production
```

### Optional Variables
```bash
# Server
FLASK_ENV=development|production|testing
PORT=5001

# Upload Limits
MAX_UPLOAD_SIZE_MB=3
TEMP_DIR=/tmp/wardrobe_temp
TEMP_FILE_TTL_MINUTES=30

# Rate Limiting
RATE_LIMIT_PER_MINUTE=10
RATE_LIMIT_ENABLED=true

# Models
MODEL_INPUT_SIZE=320
MODEL_CACHE_DIR=models/weights
USE_REMBG=true

# Gemini API (Optional - Phase 4)
GOOGLE_STUDIO_KEY=<your-api-key>
GEMINI_MODEL=gemini-1.5-flash
GEMINI_TIMEOUT_SECONDS=60
GEMINI_JOB_TTL_HOURS=1

# CORS
CORS_ORIGINS=*

# Logging
LOG_LEVEL=INFO|DEBUG|WARNING|ERROR
```

---

## Implementation Phases

### ✅ Phase 1: Foundation (Complete)
- Blueprint architecture
- Ephemeral file management
- Image utilities
- Validation
- Rate limiting
- 85+ tests

### 🔄 Phase 2: Garment Processing (In Progress)
- Segmentation with rembg
- Color extraction
- Thumbnail generation
- **Endpoints**: `/process/segment`, `/process/thumbnail`

### ⏳ Phase 3: Low-Res Try-On (Pending)
- Affine transformations
- Alpha blending
- Exposure compensation
- **Endpoint**: `/tryon/lowres`

### ⏳ Phase 4: High-Res Try-On (Pending)
- Gemini API integration
- Async job management
- Job polling
- **Endpoints**: `/tryon/highres`, `/tryon/result/<job_id>`

### ⏸️ Phase 6: Deferred Features
- Outfit suggestion engine (`/suggest`)
- Advanced analytics
- ONNX optimization

---

## Example Workflows

### Workflow 1: Add Garment to Wardrobe

```bash
# 1. Upload and segment garment
curl -X POST http://localhost:5001/process/segment \
  -F "image=@new_shirt.jpg" \
  -F "type_hint=top"

# Response: mask_png, colors, type
# Client saves mask and metadata locally

# 2. (Optional) Generate thumbnail for multiple items
curl -X POST http://localhost:5001/process/thumbnail \
  -F "images[]=@shirt1.jpg" \
  -F "images[]=@shirt2.jpg" \
  -F "images[]=@pants.jpg"

# Response: thumbnail_png
# Client saves thumbnail locally
```

### Workflow 2: Virtual Try-On

```bash
# 1. Quick preview (low-res)
curl -X POST http://localhost:5001/tryon/lowres \
  -F "selfie=@selfie.jpg" \
  -F "garment_images[]=@shirt.jpg" \
  -F "masks[]=@shirt_mask.png"

# Response: preview_png (immediate)

# 2. High-quality export (opt-in)
curl -X POST http://localhost:5001/tryon/highres \
  -F "selfie=@selfie.jpg" \
  -F "garment_images[]=@shirt.jpg"

# Response: { job_id: "abc123", status: "processing" }

# 3. Poll for result
curl http://localhost:5001/tryon/result/abc123

# Response (when ready): { status: "completed", result_png: "..." }
```

### Workflow 3: Outfit Suggestion

```bash
# Send wardrobe metadata (no images)
curl -X POST http://localhost:5001/suggest \
  -H "Content-Type: application/json" \
  -d '{
    "items": [
      {"id": "1", "garment_type": "top", "colors": ["red"]},
      {"id": "2", "garment_type": "bottom", "colors": ["blue"]},
      {"id": "3", "garment_type": "shoes", "colors": ["white"]}
    ],
    "context": {"occasion": "casual", "weather": "sunny"},
    "limit": 3
  }'

# Response: ranked outfit combinations
```

---

## Security Considerations

### Implemented
- ✅ File extension validation
- ✅ MIME type verification (python-magic)
- ✅ File size limits
- ✅ Path traversal protection (filename sanitization)
- ✅ Rate limiting per IP
- ✅ CORS configuration
- ✅ Automatic file cleanup (ephemeral storage)

### Recommended for Production
- [ ] Add authentication (API keys or JWT)
- [ ] HTTPS/TLS encryption
- [ ] Input sanitization for JSON payloads
- [ ] Request ID tracking for debugging
- [ ] Structured logging with correlation IDs
- [ ] DDoS protection (Cloudflare, etc.)
- [ ] Network-level restrictions (firewall, VPC)

---

## Support & Troubleshooting

### Common Issues

**"Rate limit exceeded"**
- Wait for `retry_after` seconds
- Reduce request frequency
- Contact admin to increase limit

**"File too large"**
- Compress image before upload
- Check `max_upload_size_mb` in `/health`

**"Invalid MIME type"**
- Ensure file is actual image (not renamed)
- Use allowed formats: JPG, PNG, WEBP

**"Not Implemented (501)"**
- Feature is planned but not yet available
- Check `PROGRESS.md` for implementation timeline

### Getting Help

- Check `/health` endpoint for server status
- Review logs for detailed error messages
- Consult `IMPLEMENTATION_PLAN.md` for feature roadmap
- Open GitHub issue for bugs or feature requests

---

**Last Updated**: December 7, 2024
**API Version**: 1.0.0-mvp
