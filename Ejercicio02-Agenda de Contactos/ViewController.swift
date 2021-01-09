//
//  ViewController.swift
//  Ejercicio02-Agenda de Contactos
//
//  Created by Marcos Ledesma on 08/01/2021.
//  Copyright © 2021 Marcos Ledesma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // Variables de la vista (txt)
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtApellidos: UITextField!
    @IBOutlet weak var txtEdad: UITextField!
    @IBOutlet weak var lblResumen: UILabel!
    @IBOutlet weak var txtNumContacto: UITextField!
    
    // Variables para la lógica
    var contactos: [ContactoModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Llamar a la func
        actualizaResumen()
    }

    // Func contar contactos del array
    func actualizaResumen() {
        lblResumen.text = "Contactos almacenados \(contactos.count)"
    }
    
    func limpiaCampos(){
        txtNombre.text = ""
        txtApellidos.text = ""
        txtEdad.text = ""
    }
    
    // Func para crear el nuevo contacto (btnAddContacto), almacenarlo en el array y después actualizar el lblResumen y limpiar los campos
    @IBAction func btnAddContactoClick() {
        // Si los txt no están vacíos, crea el contacto
        if let nombre = txtNombre.text,
            let apellidos = txtApellidos.text,
            let edad = Int(txtEdad.text ?? "0")
        {
            let contacto = ContactoModel(nombre: nombre, apellidos: apellidos, edad: edad)
            // Guardarlo en la lista
            contactos.append(contacto)
            // Actualizar resumen y limpiar campos
            actualizaResumen()
            limpiaCampos()
        }
    }
    
    // Comprobar qué segue se está activando (a qué ventana vas)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "VerContacto":
            var contacto = ContactoModel(nombre: "ERROR", apellidos: "ERROR", edad: 0)
            if let numContacto = Int(txtNumContacto.text ?? "0")
            {
                if numContacto >= 1 && numContacto <= contactos.count
                {
                    contacto = contactos[numContacto-1]
                }
            }
            // Cuando ya tengo el contacto accedo al destino
            let destino = segue.destination as! VerContactoViewController
            destino.contacto = contacto
        default:
            print("HOLA")
        }
    }
}

