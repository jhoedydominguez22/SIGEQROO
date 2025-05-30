<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Serie;

class SerieController extends Controller
{
public function getSeriesBySeccion($id)
{
    $series = Serie::where('id_seccion', $id)->get();

    if ($series->isEmpty()) {
        return response()->json([
            'status' => 'empty',
            'message' => 'No hay series registradas para esta sección.'
        ], 200);
    }

    return response()->json($series);
}

public function store(Request $request)
{
    $request->validate([
        'nombre' => 'required|string|max:255',
        'codigo' => 'required|string|max:50',
        'descripcion' => 'nullable|string',
        'id_seccion' => 'required|exists:secciones,id'
    ]);

    $serie = Serie::create([
        'nombre' => $request->nombre,
        'codigo' => $request->codigo,
        'descripcion' => $request->descripcion,
        'id_seccion' => $request->id_seccion
    ]);

    return response()->json($serie);
}



}
