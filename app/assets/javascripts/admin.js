$(document).ready(() => {
    console.log('What up!');
    loadProducts();

    $('#add-product').submit(e => {
        e.preventDefault();
        createProduct();
    });
});
// Need these for delete & edit events since we are building the table via ajax.
$(document).on('click', '.delete', function(e) {
    let id = $(this).attr('id');
    alert(id);
    destroy(id);
});

$(document).on('click', '.edit', function (e) {
    let id = $(this).attr('id');
    alert(id);
});
// ********

function loadProducts() {
    $.ajax({
        url: '/products.json',
        type: 'GET',
        success: data => {
            console.log(data);
            renderProductTable(data);
        },
        error: data => {
            console.log(data);
        }
    });
}

function createProduct(e) {
    let formData = $('#add-product').serializeArray();
    let postData = {};
    formData.forEach((field) => {
        console.log(field.value);
        postData[field.name] = field.value
    });

    console.log(postData);

    $.ajax({
        url: '/products.json',
        type: 'POST',
        data: {product: postData},
        success: data => {
            console.log(data);
            renderProductTable([data]);
        },
        error: data => {
            console.log(data);
        }
    });
}

function renderProductTable(products) {
    let html = '';
    products.forEach( (v, k) => {
        html += "<tr>";
        html += `<td>${v.name}</td>`
        html += `<td>${v.type}</td>`
        html += `<td>${v.length}</td>`
        html += `<td>${v.width}</td>`
        html += `<td>${v.height}</td>`
        html += `<td>${v.weight}</td>`
        html += `<td><button id=${v._id.$oid} class="edit btn btn-small btn-info">Edit</button></td>`
        html += `<td><button id=${v._id.$oid} class="delete btn btn-small btn-danger">Delete</button></td>`
        html += "</tr>";
    });
    $('#product-table > tbody:last-child').append(html);
}

function destroy(product_id) {
    $.ajax({
        url: `/products/${product_id}.json`,
        type: 'DELETE',
        success: data => {
            console.log(data);
            location.reload();
        },
        error: data => {
            console.log(data);
        }
    });
}