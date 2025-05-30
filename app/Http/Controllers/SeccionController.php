<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Seccion;
use App\Models\CatalogoArchivistico;

class SeccionController extends Controller
{
 public function store(Request $request, $fondoId)
{
    $request->validate([
        'nombre' => 'required|string|max:255',
        'codigo' => 'required|string|max:100',
        'descripcion' => 'nullable|string',
    ]);

    $seccion = new Seccion();
    $seccion->nombre = $request->nombre;
    $seccion->codigo = $request->codigo;
    $seccion->descripcion = $request->descripcion;
    $seccion->id_fondo = $fondoId;
    $seccion->save();

    return response()->json([
        'message' => 'Sección creada correctamente',
        'seccion' => $seccion
    ], 201);
}



}
