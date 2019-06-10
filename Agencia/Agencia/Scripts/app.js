angular.module("agencia", [])
.controller("vuelos", function ($scope, $http) {

    $scope.buscarLugar = function () {
        if ($scope.salida != "") {
            $http.post("Lugares", { salida: $scope.salida })
            .success(function (data) {
                console.log(data);
                $scope.lugares = data;
            })
            .error(function (data) {
                console.log(data);
            });
        }else
            $scope.lugares = ""
    };

    $scope.cambioLugar = function(data,codigo){
        $scope.salida = data;
        $scope.codigo_salida = codigo;
        $scope.lugares = {};
    }


    $scope.buscarDestino = function () {
        if ($scope.destino != "") {
            $http.post("Destinos", { destino: $scope.destino })
            .success(function (data) {
                console.log(data);
                $scope.destinos = data;
            }).error(function (data) {
                console.log(data);
            })
        } else
            $scope.destinos = {};

    }
    $scope.cambiarDestino = function (data,codigo) {
        $scope.destino = data;
        $scope.codigo_destino = codigo;
        $scope.destinos = {};
    }

})


.controller("reservacion", function ($scope, $http,$location) {
    $scope.articulos = [];
    $scope.val = 0;
    $scope.total = function () {
        var t = 0;
        for (var i = 0; i < $scope.articulos.length; i++) {
           t = t + $scope.articulos[i].subTotal;
        }
        return t;
    }

    $scope.buscarReservacion = function () {
        if ($scope.codigo_res != "")
        $http.post("detalleReservacion", { reservacion: $scope.codigo_res })
        .success(function (data) {
            console.log(data);
            $scope.articulos = data;
        })
    }
})

.controller("registroCliente", function ($scope, $http) {
    $scope.p = {}
    $scope.buscarUsuario = function () {
        $http.post("../../Facturacion/buscarPersona", { dpi: $scope.dpi })
        .success(function (data) {
            console.log(data);
            if (data.length > 0)
            {
                console.log(data);
                var fecha = data[0].fecha_nacimiento.split("-");
                $scope.p =
                {
                    codigo: data[0].codigo,
                    nombres: data[0].nombres,
                    apellidos: data[0].apellidos,
                    nit: data[0].nit,
                    email: data[0].email,
                    dpi: data[0].email,
                    direccion: data[0].direccion,
                    telefono: data[0].telefono,
                    fecha_nacimiento: new Date(fecha[0],fecha[1], fecha[2])
                }
            }else
                $scope.p = {}            
        })
    }
})

.controller("factura", function ($scope,$http) {
    var f = new Date();
    $scope.articulos = [];
    $scope.val = 0;
    $scope.fecha = new Date(f.getFullYear(), f.getMonth(), f.getDate());

    $scope.total = function () {
        var t = 0;
        for (var i = 0; i < $scope.articulos.length; i++) {
            t = t + $scope.articulos[i].subTotal;
        }
        return t;
    }

    $scope.verDetalle = function () {
        console.log($scope.reservacion);
        $http.post("../../Paquetes/detalleReservacion", { reservacion: $scope.reservacion })
           .success(function (data) {
               $scope.articulos = data;
               console.log(data);
           })
    }

   

})

.controller("cruceros",function($scope,$http){
    $scope.cruceros = [];

    $scope.buscarCrucero = function () {
        if ($scope.query != "") {
            $http.post("ver_cruceros", { query: $scope.query })
            .success(function (data) {
                console.log(data);
                $scope.cruceros = data;
            })
            .error(function (data) {
                console.log(data);
            });
        } else
            $scope.cruceros = []
    };

    $scope.cambioCrucero = function (codigo, crucero) {
        console.log(codigo);
        $scope.query = crucero;
        $scope.puerto = codigo;
        $scope.cruceros = [];
    }
})