# Perchwell Real Estate API

A full-stack web application built with React and Ruby on Rails that enables real estate companies to manage their building portfolios. Features include:

- Custom field configuration for each client's unique building attributes
- RESTful API endpoints for building creation, updates, and retrieval
- React components for intuitive building management
- PostgreSQL database with associations between clients, buildings, and custom fields


## Installation

```
docker compose up --build
```
Server is running at http://localhost:3000/

## Configuration

For convenience, source the alias to access the Rails container:   

```
source .aliases
```

Seed the database with:

```
perchweb rails db:seed
```

Run yarn, rails, and othercommands on the Rails container with:

```
perchweb rails <command>
perchweb yarn <command>
perchweb bundle <command>
```
Run tests on the test container with:

```
perchtest yarn test
perchtest rspec
```

## API Reference

<details>
<summary><strong>Buildings API</strong></summary>

### `GET /api/buildings`

Retrieves a paginated list of buildings for a specific client, including custom field values.

**Query Parameters:**
- `client_id` (integer, required): ID of the client whose buildings to retrieve
- `page` (integer, optional): Page number for pagination
- `per_page` (integer, optional): Number of buildings per page (default: 5)

**Response:**
```json
{
  "buildings": [
    {
      "id": 1,
      "client_name": "Example Client",
      "address": "123 Main St",
      "custom_field_1": "value1",
      "custom_field_2": "value2"
    }
  ],
  "meta": {
    "current_page": 1,
    "total_pages": 10,
    "total_count": 50,
    "per_page": 5
  }
}
```

**Status Codes:**
- `200 OK`: Successfully retrieved buildings
- `400 Bad Request`: No client_id provided
- `404 Not Found`: Client not found

### `GET /api/buildings/:id`

Retrieves a specific building by ID.

**Status Codes:**
- `200 OK`: Successfully retrieved building
- `404 Not Found`: Building not found

### `POST /api/buildings`

Creates a new building with associated custom field values.

**Request Body:**
```json
{
  "building": {
    "client_id": 1,
    "address": "123 Main St",
    "zip_code_id": 12345,
    "custom_values": {
      "custom_field_1": "value1",
      "custom_field_2": "value2"
    }
  }
}
```

**Status Codes:**
- `201 Created`: Successfully created building
- `422 Unprocessable Entity`: Validation errors

### `PUT /api/buildings/:id`

Updates an existing building and its custom field values.

**Request Body:**
```json
{
  "building": {
    "address": "124 Main St",
    "zip_code_id": 12345,
    "custom_values": {
      "custom_field_1": "updated_value1",
      "custom_field_2": "updated_value2"
    }
  }
}
```

**Status Codes:**
- `200 OK`: Successfully updated building
- `404 Not Found`: Building not found
- `422 Unprocessable Entity`: Validation errors
</details>

<details>
<summary><strong>Clients API</strong></summary>

### `GET /api/clients`

Retrieves a paginated list of clients with their associated buildings and custom fields.

**Query Parameters:**
- `page` (integer, optional): Page number for pagination
- `per_page` (integer, optional): Number of clients per page (default: 1)

**Response:**
```json
{
  "clients": [
    {
      "id": 1,
      "name": "Example Client",
      "buildings": [
        {
          "id": 1,
          "address": "123 Main St",
          // ... other building attributes
        }
      ],
      "custom_fields": [
        {
          "id": 1,
          "name": "field_name",
          // ... other custom field attributes
        }
      ]
    }
  ],
  "meta": {
    "current_page": 1,
    "total_pages": 10,
    "total_count": 50,
    "per_page": 1
  }
}
```

**Status Codes:**
- `200 OK`: Successfully retrieved clients
- `500 Internal Server Error`: Failed to load clients
</details>

<details>
<summary><strong>Zip Codes API</strong></summary>

### `GET /api/zip_codes`

Retrieves a list of all zip codes with their associated state information.

**Response:**
```json
[
  {
    "id": 1,
    "code": "12345",
    "city": "Example City",
    "state": {
      "id": 1,
      "name": "Example State"
    }
  }
]
```

**Status Codes:**
- `200 OK`: Successfully retrieved zip codes

### `GET /api/zip_codes/:id`

Retrieves a specific zip code by ID with its state information.

**Response:**
```json
{
  "id": 1,
  "code": "12345",
  "city": "Example City",
  "state": {
    "id": 1,
    "name": "Example State"
  }
}
```

**Status Codes:**
- `200 OK`: Successfully retrieved zip code
- `404 Not Found`: Zip code not found
</details>

