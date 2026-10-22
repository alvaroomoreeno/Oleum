package es.uah.oleum.model;

import java.sql.Timestamp;

public class Pedido {
    private int id;
    private int usuarioId;
    private Timestamp fecha;
    private String estado;
    private String direccionEnvio;
    private double total;

    public Pedido() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUsuarioId() { return usuarioId; }
    public void setUsuarioId(int usuarioId) { this.usuarioId = usuarioId; }

    public Timestamp getFecha() { return fecha; }
    public void setFecha(Timestamp fecha) { this.fecha = fecha; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public String getDireccionEnvio() { return direccionEnvio; }
    public void setDireccionEnvio(String direccionEnvio) { this.direccionEnvio = direccionEnvio; }

    public double getTotal() { return total; }
    public void setTotal(double total) { this.total = total; }
}