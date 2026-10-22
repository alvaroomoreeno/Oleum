package es.uah.oleum.model;

public class Producto {
    private int id;
    private int categoriaId;
    private String nombre;
    private String productor;
    private String origen;
    private String variedad;
    private int formatoMl;
    private double precio;
    private int stock;
    private String imagen;
    private boolean activo;

    public Producto() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getCategoriaId() { return categoriaId; }
    public void setCategoriaId(int categoriaId) { this.categoriaId = categoriaId; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getProductor() { return productor; }
    public void setProductor(String productor) { this.productor = productor; }

    public String getOrigen() { return origen; }
    public void setOrigen(String origen) { this.origen = origen; }

    public String getVariedad() { return variedad; }
    public void setVariedad(String variedad) { this.variedad = variedad; }

    public int getFormatoMl() { return formatoMl; }
    public void setFormatoMl(int formatoMl) { this.formatoMl = formatoMl; }

    public double getPrecio() { return precio; }
    public void setPrecio(double precio) { this.precio = precio; }

    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }

    public String getImagen() { return imagen; }
    public void setImagen(String imagen) { this.imagen = imagen; }

    public boolean isActivo() { return activo; }
    public void setActivo(boolean activo) { this.activo = activo; }
}