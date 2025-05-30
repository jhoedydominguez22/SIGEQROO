<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Seccion extends Model
{
    protected $table = 'secciones';

    protected $fillable = [
        'nombre',
        'codigo',
        'descripcion',
        'id_fondo',
    ];

    // Una sección pertenece a un fondo
    public function fondo()
    {
        return $this->belongsTo(Fondo::class, 'id_fondo');
    }

    // Una sección tiene muchas series
    public function series()
    {
        return $this->hasMany(Serie::class, 'id_seccion');
    }
}
