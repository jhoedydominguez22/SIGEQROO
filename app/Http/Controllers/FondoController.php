<?php

// app/Http/Controllers/FondoController.php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Fondo;
use Illuminate\Support\Facades\DB;

class FondoController extends Controller
{
    public function store(Request $request)
{
    // Validar los datos recibidos
    $request->validate([
        'nombre' => 'required|string|max:255',
        'codigo' => 'required|string|max:50|unique:fondos,codigo',
        'descripcion' => 'nullable|string',
    ]);

    // Crear el nuevo fondo
    $fondo = new Fondo();
    $fondo->nombre = $request->input('nombre');
    $fondo->codigo = $request->input('codigo');
    $fondo->descripcion = $request->input('descripcion');
    $fondo->save();

    // Devolver respuesta
    return response()->json([
        'message' => 'Fondo creado correctamente.',
        'fondo' => $fondo
    ], 201);
}


    public function index()
    {
        // Obtener todos los fondos
        $fondos = DB::table('fondos')
            ->select('id', 'nombre', 'codigo', 'descripcion', 'created_at')
            ->orderBy('created_at', 'desc')
            ->get();

        return response()->json($fondos);
    }


       public function secciones($id)
    {
        $fondo = Fondo::findOrFail($id);
        return $fondo->secciones;
    }

    

}
