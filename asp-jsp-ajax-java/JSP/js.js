
var contador = 0;
/**
* FUNCION PARA COMPROBAR QUE EL PRODUCTO ESTA EN LA TABLA DINAMICA
**/
function comprobar_producto(producto){
  var table_2 = document.getElementById("id_tabla");
  for(i=1;i<table_2.rows.length;i++)
  {
    if(producto==(table_2.rows[i].cells[1].innerHTML))
      return true;
  }
  return false;
}

/**
* FUNCION PARA DEVOLVER EN QUE LINEA DE LA TABLA DINAMICA
* ESTA EL PRODUCTO
**/
function linea_producto(producto){
  var table_2 = document.getElementById("id_tabla");
  for(i=1;i<table_2.rows.length;i++)
  {
    if(producto==(table_2.rows[i].cells[1].innerHTML))
      return i;
  }
  return i;
}

/**
* FUNCION PARA ANADIR PRODUCTOS A LA TABLA DINAMICA,

**/
function productos(){

  var total=0;
    
  if (contador==0) {
    var table = document.createElement('table');
    var tbody = document.createElement('tbody');  

    var tr = document.createElement('tr');   

    var td1 = document.createElement('td');
    var td2 = document.createElement('td');
    var td3 = document.createElement('td');
    var td4 = document.createElement('td');

    var text1 = document.createTextNode('Cantidad');
    var text2 = document.createTextNode('Producto');
    var text3 = document.createTextNode('Precio');
    var text4 = document.createTextNode('Subtotal');

    var class_tr = document.createAttribute("class");
    class_tr.value = "titulo_tabla";
    tr.setAttributeNode(class_tr);

    td1.appendChild(text1);
    td2.appendChild(text2);
    td3.appendChild(text3);
    td4.appendChild(text4);

    tr.appendChild(td1);
    tr.appendChild(td2);
    tr.appendChild(td3);
    tr.appendChild(td4);

    tbody.appendChild(tr);
    table.appendChild(tbody);
    document.getElementById("contenido_prod").appendChild(table);

    var class_table = document.createAttribute("class");
    class_table.value = "tabla_compra";
    table.setAttributeNode(class_table);

    var id_table = document.createAttribute("id");
    id_table.value = "id_tabla";
    table.setAttributeNode(id_table);


    var row = table.insertRow(1);
    var cell1 = row.insertCell(0);
    var cell2 = row.insertCell(1);
    var cell3 = row.insertCell(2);
    var cell4 = row.insertCell(3);
    cell1.innerHTML = document.getElementById('cantidad').value;
    cell2.innerHTML = document.getElementById("producto").options[document.getElementById("producto").selectedIndex ].text;
    cell3.innerHTML = document.getElementById('producto').value;
    cell4.innerHTML = document.getElementById('cantidad').value * document.getElementById('producto').value;


    table = document.createElement('table');
    tr = document.createElement('tr');   

    td1 = document.createElement('td');
    td2 = document.createElement('td');

    var class_td = document.createAttribute("class");
    class_td.value = "titulo_tabla";
    td1.setAttributeNode(class_td);

    total = document.getElementById('cantidad').value * document.getElementById('producto').value +"€";

    text1 = document.createTextNode('Total: ');
    text2 = document.createTextNode(total);

    td1.appendChild(text1);
    td2.appendChild(text2);
      
    tr.appendChild(td1);
    tr.appendChild(td2);
      
    table.appendChild(tr);
    document.getElementById("contenido_prod").appendChild(table);

    class_table = document.createAttribute("class");
    class_table.value = "tabla_compra";
    table.setAttributeNode(class_table);

    id_table = document.createAttribute("id");
    id_table.value = "id_total";
    table.setAttributeNode(id_table);

    contador++;
  }
  else
  {
    var table_2 = document.getElementById("id_tabla");
    var total = document.getElementById('cantidad').value * document.getElementById('producto').value;
    //Comprobamos si el producto esta ya en la tabla
    if(comprobar_producto((document.getElementById("producto").options[document.getElementById("producto").selectedIndex ].text)))
    {
      //Comprobamos la linea en la que esta el producto en la tabla
      var linea = linea_producto((document.getElementById("producto").options[document.getElementById("producto").selectedIndex ].text));
      table_2.rows[linea].cells[0].innerHTML=parseInt(table_2.rows[linea].cells[0].innerHTML)+parseInt(document.getElementById('cantidad').value);
      table_2.rows[linea].cells[3].innerHTML=(parseFloat(table_2.rows[linea].cells[3].innerHTML)+parseFloat(total)).toFixed(2);

      document.getElementById("id_total").rows[0].cells[1].innerHTML=(parseFloat(document.getElementById("id_total").rows[0].cells[1].innerHTML)+total).toFixed(2) +"€";
    }
    else
    {
      var row_2 = table_2.insertRow(contador+1);
      var cell1_2 = row_2.insertCell(0);
      var cell2_2 = row_2.insertCell(1);
      var cell3_2 = row_2.insertCell(2);
      var cell4_2 = row_2.insertCell(3);
      cell1_2.innerHTML = document.getElementById('cantidad').value;
      cell2_2.innerHTML = document.getElementById("producto").options[document.getElementById("producto").selectedIndex ].text;
      cell3_2.innerHTML = document.getElementById('producto').value;
      cell4_2.innerHTML = total;

      document.getElementById("id_total").rows[0].cells[1].innerHTML=(parseFloat(document.getElementById("id_total").rows[0].cells[1].innerHTML)+total).toFixed(2) +"€";
      contador++; 
    } 
  }
}


/**
* PARA QUE CARGUE EL JAVASCRIPT DESPUES DEL HTML
**/
window.onload =  function(){
  
  anadir_productos();
  
}

