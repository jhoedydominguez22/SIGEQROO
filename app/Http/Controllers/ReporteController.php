<?php

namespace App\Http\Controllers;

use App\Models\Expediente;
use Illuminate\Http\Request;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Support\Facades\Auth;

class ReporteController extends Controller
{
    public function filtrar(Request $request)
{
    $user = Auth::user();

    $query = Expediente::query();

    // Solo mostrar expedientes del área asignada al usuario
    $query->where('ubicacion_topografica', $user->area_asignada);

    if ($request->estado) {
        $query->where('estado', $request->estado);
    }

    if ($request->fecha_inicio && $request->fecha_fin) {
        $query->whereBetween('fecha_apertura', [$request->fecha_inicio, $request->fecha_fin]);
    }

    if ($request->id_serie) {
        $query->where('id_serie', $request->id_serie);
    }

    return response()->json($query->get());
}

public function generarPDF(Request $request)
{
    $query = Expediente::query();
    $estadoFiltro = null;

    if ($request->estado) {
        $query->where('estado', $request->estado);
        $estadoFiltro = $request->estado;
    }

    if ($request->fecha_inicio && $request->fecha_fin) {
        $query->whereBetween('fecha_apertura', [$request->fecha_inicio, $request->fecha_fin]);
    }

    if ($request->id_serie) {
        $query->where('id_serie', $request->id_serie);
    }

    $expedientes = $query->get();

    // ✅ Definir variables antes de pasarlas a la vista
    $fechaInicio = $request->fecha_inicio;
    $fechaFin = $request->fecha_fin;

    $pdf = Pdf::loadView('pdf.expedientes', compact('expedientes', 'estadoFiltro', 'fechaInicio', 'fechaFin'))
        ->setPaper('legal', 'landscape');

    return $pdf->download('reporte_expedientes.pdf');
}


}
