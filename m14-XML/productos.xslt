<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <html>
      <head>
        <title>Productos</title>
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
        <h2>Listado de Productos</h2>
        <table>
          <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Tipo</th>
            <th>Precio</th>
            <th>Descripción</th>
          </tr>
          <xsl:for-each select="productos/producto">
            <tr>
              <td><xsl:value-of select="id"/></td>
              <td><xsl:value-of select="nombre"/></td>
              <td><xsl:value-of select="tipo"/></td>
              <td><xsl:value-of select="preu"/></td>
              <td><xsl:value-of select="descripcion"/></td>
            </tr>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
