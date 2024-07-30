-- Importar dados
WITH source AS (
    SELECT 
        nota,
        escola,
        unidade
    FROM 
        {{ source ('dbnps', 'Base_NPSPagina1')}}
),

-- Renomear colunas
renamed AS (
    SELECT
        CAST(nota AS INT) AS NPS,
        escola AS Escola,
        unidade AS Unidade
    FROM    
        source
)

SELECT * FROM renamed
