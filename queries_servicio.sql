--1) Meses con Mayor Demanda de Eventos:

SELECT
    MONTHNAME(e.FechaEvento) AS Mes,
    COUNT(DISTINCT e.IDEvento) AS TotalEventos,
    SUM(ventas.TicketsVendidos) AS TicketsVendidos,
    GROUP_CONCAT(DISTINCT ventas.EventoMasVendido SEPARATOR ', ') AS EventosMasVendidos
FROM
    evento e
LEFT JOIN (
    SELECT 
        t.IDEvento,
        COUNT(t.IDTicket) AS TicketsVendidos,
        e.NombreEvento AS EventoMasVendido
    FROM 
        tickets t
    JOIN 
        evento e ON t.IDEvento = e.IDEvento
    GROUP BY 
        t.IDEvento, e.NombreEvento
) ventas ON ventas.IDEvento = e.IDEvento
GROUP BY 
    Mes
ORDER BY 
    TotalEventos DESC;

--2) Mejores organizadores por ingresos totales

SELECT 
    o.IDOrganizador,
    o.NombreOrganizador,
    ROUND(SUM(f.Gasto),2) AS TotalIngresos,
    COUNT(DISTINCT e.IDEvento) AS TotalEventos
FROM   
    organizadores o
JOIN 
    evento e ON o.IDOrganizador = e.IDOrganizador
JOIN 
    tickets t ON e.IDEvento = t.IDEvento
JOIN 
    facturas f ON t.IDTicket = f.IDTicket
GROUP BY 
    o.IDOrganizador, o.NombreOrganizador  
ORDER BY 
    TotalIngresos DESC;

--3) Eventos con sus Ingresos

SELECT 
    e.NombreEvento AS NombreEvento,
    COUNT(t.IDTicket) AS EntradasVendidas,
    ROUND(SUM(t.Precio),2) AS IngresosTotales
FROM 
    Evento e
JOIN 
    Tickets t ON e.IDEvento = t.IDEvento
GROUP BY 
    e.IDEvento, e.NombreEvento
ORDER BY 
    EntradasVendidas DESC;

--#4) Eventos con mayor precio
SELECT 
    e.IDEvento AS EventoID,
    e.NombreEvento AS NombreEvento,
    MAX(t.Precio) AS PrecioMaximo
FROM 
    Evento e
JOIN 
    Tickets t ON e.IDEvento = t.IDEvento
GROUP BY 
    e.IDEvento, e.NombreEvento
ORDER BY 
    PrecioMaximo DESC;

--#5) Entradas por evento

CREATE VIEW EntradasPorEvento AS
SELECT 
    evento.IDEvento, 
    evento.NombreEvento, 
    COUNT(t.IDTicket) AS TotalEntradasVendidas, 
    ROUND(SUM(t.Precio),2) AS IngresosGenerados
FROM 
    Evento evento
JOIN 
    Tickets t ON evento.IDEvento = t.IDEvento
GROUP BY 
    evento.IDEvento, evento.NombreEvento
ORDER BY
TotalEntradasVendidas DESC;

-- #6)Promedio de Entradas por Evento por Asistente:
    SELECT 
        e.IDEvento AS EventoID,
        e.NombreEvento AS NombreEvento,
        AVG(t.Precio) AS PromedioEntradasVendidas
    FROM 
        Evento e
    JOIN 
        Tickets t ON e.IDEvento = t.IDEvento
    GROUP BY 
        e.IDEvento, e.NombreEvento
    ORDER BY 
        PromedioEntradasVendidas DESC;

--#7) Eventos que están por ocurrir.

CREATE VIEW EventosProximos AS
SELECT 
    e.IDEvento, 
    e.NombreEvento, 
    e.FechaEvento
FROM 
    Evento e
WHERE 
    e.FechaEvento > CURDATE()
ORDER BY 
    e.FechaEvento;