<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Expediente;
use App\Models\Serie;
use App\Models\User;

use Illuminate\Support\Facades\Auth;


class ExpedienteController extends Controller
{

    public function store(Request $request)
    {
        $request->validate([
            'nombre' => 'required|string|max:255',
            'codigo' => 'required|string|max:50',
            'id_serie' => 'required|exists:series,id',
            'estado' => 'required|in:en_tramite,en_historico,en_concentracion', // <- agrega todos los estados posibles
            'fecha_apertura' => 'nullable|date',
            'fecha_cierre' => 'nullable|date|after_or_equal:fecha_apertura',
            'fecha_creacion' => 'nullable|date',
            'tiempo_conservacion' => 'nullable|numeric', // antes era string
            'no_legajos' => 'nullable|integer|min:0',
            'no_hojas' => 'nullable|integer|min:0',
            'no_caja' => 'nullable|integer|min:0',
            'ubicacion_topografica' => 'nullable|string|max:255',
            'clasificacion' => 'required|in:Pública,Reservada,Confidencial',
            'caracter' => 'required|in:Administrativo,Legal,Contable',
            'preservacion' => 'nullable|string|max:255',
            'observacion' => 'nullable|string|max:1000'
        ]);


        // Obtener la serie con sus relaciones
        $serie = Serie::with('seccion.fondo')->findOrFail($request->id_serie);

        // Construir la clave del expediente
        $codigoFondo = $serie->seccion->fondo->codigo ?? '';
        $codigoSeccion = $serie->seccion->codigo ?? '';
        $codigoSerie = $serie->codigo ?? '';
        $codigoExpediente = $request->input('codigo');

        $clave = "{$codigoFondo}/{$codigoSeccion}/{$codigoSerie}/{$codigoExpediente}";

        // Crear el expediente
        $expediente = new Expediente();
        $expediente->nombre = $request->input('nombre');
        $expediente->codigo = $codigoExpediente;
        $expediente->clave = $clave;
        $expediente->id_serie = $request->input('id_serie');
        $expediente->estado = $request->input('estado');
        $expediente->fecha_apertura = $request->input('fecha_apertura');
        $expediente->fecha_cierre = $request->input('fecha_cierre');
        $expediente->fecha_creacion = $request->input('fecha_creacion');
        $expediente->tiempo_conservacion = $request->input('tiempo_conservacion');
        $expediente->no_legajos = $request->input('no_legajos');
        $expediente->no_hojas = $request->input('no_hojas');
        $expediente->no_caja = $request->input('no_caja');
        $expediente->ubicacion_topografica = $request->input('ubicacion_topografica');
        $expediente->clasificacion = $request->input('clasificacion');
        $expediente->caracter = $request->input('caracter');
        $expediente->preservacion = $request->input('preservacion');
        $expediente->observacion = $request->input('observacion');
        $expediente->save();

        return response()->json([
            'message' => 'Expediente creado correctamente.',
            'expediente' => $expediente
        ], 201);
    }


    public function porSerie($id)
    {
        $expedientes = Expediente::where('id_serie', $id)->get();
        return response()->json($expedientes);
    }



    public function index()
    {
        try {
            $user = Auth::user();

            if (!$user->area_asignada) {
                return response()->json(['error' => 'El usuario no tiene un área asignada.'], 403);
            }

            // Si el usuario es admin, trae todo; si no, filtra por ubicacion_topografica
            if ($user->hasRole('admin')) {
                $expedientes = Expediente::with(['serie.seccion.fondo', 'unidadesDocumentales'])->get();
            } else {
                $expedientes = Expediente::where('ubicacion_topografica', $user->area_asignada)
                    ->with(['serie.seccion.fondo', 'unidadesDocumentales'])
                    ->get();
            }

            $datos = $expedientes->map(function ($exp) {
                return [
                    'id' => $exp->id,
                    'nombre' => $exp->nombre,
                    'codigo' => $exp->codigo,
                    'estado' => $exp->estado,
                    'fecha_apertura' => $exp->fecha_apertura,
                    'fecha_cierre' => $exp->fecha_cierre,
                    'clave' => $exp->clave,
                    'tiempo_conservacion' => $exp->tiempo_conservacion,
                    'no_legajos' => $exp->no_legajos,
                    'no_hojas' => $exp->no_hojas,
                    'no_caja' => $exp->no_caja,
                    'ubicacion_topografica' => $exp->ubicacion_topografica,
                    'clasificacion' => $exp->clasificacion,
                    'caracter' => $exp->caracter,
                    'preservacion' => $exp->preservacion,
                    'observacion' => $exp->observacion,
                    'serie' => optional($exp->serie)->nombre,
                    'seccion' => optional(optional($exp->serie)->seccion)->nombre,
                    'fondo' => optional(optional(optional($exp->serie)->seccion)->fondo)->nombre,
                    'unidades_documentales' => $exp->unidadesDocumentales->map(function ($unidad) {
                        return [
                            'id' => $unidad->id,
                            'tipo' => $unidad->tipo,
                            'nombre' => $unidad->nombre,
                            'descripcion' => $unidad->descripcion,
                            'archivo' => $unidad->archivo,
                        ];
                    }),
                ];
            });

            return response()->json($datos);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Error al obtener los expedientes. ' . $e->getMessage()], 500);
        }
    }
}
