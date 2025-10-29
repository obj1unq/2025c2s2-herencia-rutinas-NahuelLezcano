class Rutinas {

    method descanso(tiempo) 

    method quemarCalorias(tiempo) { return 100 * (tiempo - self.descanso(tiempo)) * intensidad }
}


class Running inherits Rutinas {

    var intensidad  

    override method descanso(tiempo) = if (tiempo > 20) 5 else 2
}


class Maraton inherits Running {
    
    override method quemarCalorias(tiempo) {
        return super(tiempo) * 2

    }
}


class Remo inherits Rutinas {
    
    const property intensidad = 1.3

    override method descanso(tiempo) {return tiempo / 5}
}


class RemoDeCompeticion inherits Remo {

    override method intensidad() { return 1.7}

    override method descanso(tiempo) {
        return (tiempo-3).max(2)
    }      
}

//100 * (5 - (5-3)) * 1.7
