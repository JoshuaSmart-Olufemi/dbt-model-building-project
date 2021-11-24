WITH users AS (

    SELECT id,
    user_id,
    CONCAT(first_name,' ',last_name) as user_full_names,
    email,
    phone_number,
    created_at,
    updated_at,
    address_id
    FROM {{ source('tutorial', 'users') }}
)

SELECT * FROM users