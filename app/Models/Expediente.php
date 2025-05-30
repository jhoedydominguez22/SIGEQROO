<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Expediente extends Model
{
    protected $table = 'expedientes';

    protected $fillable = [
        'nombre',
        'codigo',
        'clave',
        'id_serie',
        'estado',
        'fecha_apertura',
        'fecha_cierre',
        'fecha_creacion',
        'tiempo_conservacion',
        'no_legajos',
        'no_hojas',
        'no_caja',
        'ubicacion_topografica',
        'clasificacion',
        'caracter',
        'preservacion',
        'observacion',
    ];


    public function serie()
    {
        return $this->belongsTo(Serie::class, 'id_serie');
    }

    public function unidadesDocumentales()
    {
        return $this->hasMany(UnidadDocumental::class, 'id_expediente');
    }
}
