// 1. Rutinas

class Rutinas {
    method descanso(tiempo) 

    method intensidad()

    method calorias(tiempo) { return 100 * (tiempo - self.descanso(tiempo)) * self.intensidad() }
}


class Running inherits Rutinas {
    const property intensidad  

    override method descanso(tiempo) { return if (tiempo > 20) 5 else 2 }
}


class Maraton inherits Running {
    
    override method calorias(tiempo) { return super(tiempo) * 2 }
}


class Remo inherits Rutinas {
    override method intensidad() { return 1.3 }

    override method descanso(tiempo) {return tiempo / 5}
}


class RemoDeCompeticion inherits Remo {
    override method intensidad() { return 1.7}

    override method descanso(tiempo) {
        return (super(tiempo) - 3).max(2)
    }      
}



// 2. Personas

class Persona {
    method tiempo()  

    var property peso 

    method kilosPorCalorias()

    method pesoPerdidosPorRutina(rutina) {
        return self.caloriasPerdidasPor(rutina) / self.kilosPorCalorias()
    }

    method caloriasPerdidasPor(rutina) {
        return rutina.calorias(self.tiempo())
    }

    method realizarPractica(rutina) {
        self.validarPractica(rutina)
        peso -= self.pesoPerdidosPorRutina(rutina)
    }

    method validarPractica(rutina) {
        if (not self.puedePracticar(rutina)) {
            self.error("No puede practicar la rutina")
        }
    }

    method puedePracticar(rutina) 
}


class Sedentario inherits Persona {

    var property tiempo 
    
    override method kilosPorCalorias() { 
        return 7000
    }

    override method puedePracticar(rutina) {
        return self.peso() > 50    
    }
}


class Atleta inherits Persona {
    
    override method tiempo() { return 90 }
    
    override method kilosPorCalorias() { 
        return 8000
    }
    
    override method pesoPerdidosPorRutina(rutina) {
        return super(rutina) - 1
    }

    override method puedePracticar(rutina) {
        return self.caloriasPerdidasPor(rutina) > 10000
    }
}


// 3. Clubes


class Club {
    const property predios

    method mejorPredioPara(persona) {
        return predios.max({ predio => predio.totalCalorias(persona) })
    }  

    method prediosTranquis(persona) {
        return predios.filter({ predio => predio.esPredioTranquiPara(persona) })
    }

    method rutinasMasExigentes(persona) {
        return predios.map({ predio => predio.rutinaMasExigente(persona) }).asSet()
    }
}


class Predio {
    const property rutinas

    method totalCalorias(persona) { 
        return rutinas.sum({ rutina => persona.caloriasPerdidasPor(rutina) }) 
    }  

    method esPredioTranquiPara(persona) {
        return rutinas.any({ rutina => persona.caloriasPerdidasPor(rutina) < 500 })
    }

    method rutinaMasExigente(persona) {
        return rutinas.max({ rutina => persona.caloriasPerdidasPor(rutina) })
    }
}