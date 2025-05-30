<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Serie extends Model
{
    use HasFactory;

    protected $table = 'series';

    protected $fillable = [
        'nombre',
        'codigo',
        'descripcion',
        'id_seccion',  // Solo esta FK ahora
        // 'id_fondo' removido porque no estará en la tabla
    ];

    // Relación: Una serie pertenece a una sección (obligatoria)
    public function seccion()
    {
        return $this->belongsTo(Seccion::class, 'id_seccion');
    }

    // Relación: Una serie tiene muchos expedientes
    public function expedientes()
    {
        return $this->hasMany(Expediente::class, 'id_serie');
    }
}
