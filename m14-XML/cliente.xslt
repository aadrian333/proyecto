<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <html>
      <head>
        <title>Clientes</title>
        <style>
          table {
            border-collapse: collapse;
            width: 100%;
          }
          th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
          }
          th {
            background-color: #f2f2f2;
          }
        </style>
      </head>
      <body>
        <h2>Listado de Clientes</h2>
        <table>
          <tr>
            <th>ID</th>
            <th>DNI</th>
            <th>Nombre</th>
            <th>Apellido</th>
            <th>Email</th>
            <th>Teléfono</th>
            <th>Fecha de Nacimiento</th>
            <th>Domicilio</th>
          </tr>
          <xsl:for-each select="clientes/cliente">
            <tr>
              <td><xsl:value-of select="id"/></td>
              <td><xsl:value-of select="dni"/></td>
              <td><xsl:value-of select="nombre"/></td>
              <td><xsl:value-of select="apellido"/></td>
              <td><xsl:value-of select="email"/></td>
              <td><xsl:value-of select="telefono"/></td>
              <td><xsl:value-of select="fecha-nacimiento"/></td>
              <td>
                <xsl:value-of select="concat(domicilio/calle, ', ', domicilio/numero, ', ', domicilio/ciudad, ', ', domicilio/codigo-postal, ', ', domicilio/pais)"/>
              </td>
            </tr>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
