#C:\IBD\UniServerZ\www\proyecto, este es mi proyecto para bases de datos

import streamlit as st
import mysql.connector
import pandas as pd

st.title("Sistema de Gestión de Eventos")
st.write("Esta aplicación muestra los asistentes, eventos, organizadores y precios de los tickets.")

def connect_db():
    try:
        return mysql.connector.connect(
            host="localhost",
            user="root",
            password="root",
            database="sistema_gestion_eventos",
            port="3306"  
        )
    except mysql.connector.Error as err:
        st.error(f"Error al conectar a la base de datos: {err}")
        return None

def get_data(query):
    conn = connect_db()
    if conn is None:
        return None
    try:
        cursor = conn.cursor(dictionary=True)
        cursor.execute(query)
        data = cursor.fetchall()
        return pd.DataFrame(data)
    except mysql.connector.Error as err:
        st.error(f"Error al ejecutar la consulta: {err}")
        return None
    finally:
        conn.close()

queries = {
    "Meses con Mayor Demanda de Eventos y Ventas": """
        SELECT
            MONTHNAME(e.FechaEvento) AS Mes,
            COUNT(e.IDEvento) AS TotalEventos,
            MAX(ventas.TicketsVendidos) AS TicketsVendidos,
            GROUP_CONCAT(ventas.EventoMasVendido SEPARATOR ', ') AS EventosMasVendidos
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
    """,
    "Mejores Organizadores por Ingresos Totales": """
        SELECT 
            o.IDOrganizador,
            o.NombreOrganizador,
            SUM(f.Gasto) AS TotalIngresos,
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
            TotalIngresos ASC;
    """,
    "Eventos e Ingresos": """
        SELECT 
            e.NombreEvento AS NombreEvento,
            COUNT(t.IDTicket) AS EntradasVendidas,
            SUM(t.Precio) AS IngresosTotales
        FROM 
            Evento e
        JOIN 
            Tickets t ON e.IDEvento = t.IDEvento
        GROUP BY 
            e.IDEvento, e.NombreEvento
        ORDER BY 
            EntradasVendidas DESC;
    """,
    "Promedio de Entradas por Evento por Asistente": """
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
    """,
    "Eventos con Mayor Precio": """
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
    """,
    "Entradas Por Evento (Vista)": """
        SELECT 
            evento.IDEvento, 
            evento.NombreEvento, 
            COUNT(t.IDTicket) AS TotalEntradasVendidas, 
            ROUND(SUM(t.Precio), 2) AS IngresosGenerados
        FROM 
            Evento evento
        JOIN 
            Tickets t ON evento.IDEvento = t.IDEvento
        GROUP BY 
            evento.IDEvento, evento.NombreEvento
        ORDER BY 
            TotalEntradasVendidas DESC;
    """,
    "Eventos que Están por Ocurrir (Vista)": """
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
    """,
    "Equipo": "Ver los integrantes del equipo"
}

team_members = [
    {"Nombre": "Abraham Martínez", "Carrera": "Ciber", "Semestre": 4, "ID": "0261312"},
    {"Nombre": "Andrea Monroy", "Carrera": "Animación y videojuegos", "Semestre": 4, "ID": "0253408"},
    {"Nombre": "Emiliano Garcia", "Carrera": "Ciber", "Semestre": 4, "ID": "0261310"}
]

query_selection = st.selectbox("Selecciona una consulta:", list(queries.keys()))

if query_selection == "Equipo":
    st.write("### Integrantes del equipo")
    for i, member in enumerate(team_members):
        if st.button(f'Ver más detalles de {member["Nombre"]}', key=f"member_{i}"):
            st.write(f"### Detalles de {member['Nombre']}")
            st.write(f"**Carrera:** {member['Carrera']}")
            st.write(f"**Semestre:** {member['Semestre']}")
            st.write(f"**ID:** {member['ID']}")
        st.write("---")
else:
    query = queries[query_selection]
    data = get_data(query)
    if data is not None and not data.empty:
        st.write(f"### Resultados encontrados: {query_selection}")
        st.dataframe(data)
    else:
        st.write("No hay resultados para mostrar.")
