{{ config(materialized='table') }}

WITH Nota AS (
    SELECT 
        NPS,
        Escola,
        Unidade
    FROM {{ ref("stg_NPS") }}
),

Calculate AS (
    SELECT 
        Escola,
        Unidade,
        ROUND(
            (100.0 * SUM(CASE WHEN CAST(NPS AS INTEGER) >= 9 THEN 1 ELSE 0 END) / COUNT(*)) - 
            (100.0 * SUM(CASE WHEN CAST(NPS AS INTEGER) <= 6 THEN 1 ELSE 0 END) / COUNT(*)), 
            2
        ) AS NPS_Calculado
    FROM 
        Nota
    GROUP BY 
        Escola, Unidade
)

SELECT 
    Escola,
    Unidade,
    NPS_Calculado
FROM 
    Calculate

