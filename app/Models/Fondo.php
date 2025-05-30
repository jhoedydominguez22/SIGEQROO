<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Fondo extends Model
{
    protected $table = 'fondos';

    protected $fillable = [
        'nombre',
        'codigo',
        'descripcion',
    ];

    // Un fondo tiene muchas series
    public function series()
    {
        return $this->hasMany(Serie::class, 'id_fondo');
    }

    // Opcional: Un fondo tiene muchas secciones (si la relación es directa también)
    public function secciones()
    {
        return $this->hasMany(Seccion::class, 'id_fondo');
    }
}
