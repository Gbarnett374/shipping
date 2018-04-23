$(document).ready(() => {
    $('#edit-modal').find("form").attr('id', 'edit-product');
    $('.alert').hide();
    loadProducts();

    $('#add-product').submit(e => {
        e.preventDefault();
        let productData = parseFormData('#add-product');
        createProduct(productData);
    });

    $('#edit-product').submit(e => {
        e.preventDefault();
        let productId = $('#edit-product').data('id');
        let productData = parseFormData('#edit-product');
        updateProduct(productData, productId)
    });
});
// Need these for delete & edit events since we are building the table via ajax.
$(document).on('click', '.delete', function(e) {
    let id = $(this).data('id');
    let el = $(this);
    destroy(id, el);
});

$(document).on('click', '.edit', function (e) {
    let productId = $(this).data('id');
    // console.log($(this));
    // let row = $(this).closest("tr");
    // console.log(row.find("td"));
    loadProduct(productId);
    $('#edit-modal').modal('toggle');

});
// ********
function loadProduct(productId) {
    $.ajax({
        url: `/products/${productId}.json`,
        type: 'GET'
    }).done(data => {
        populateModalForm(data);
    }).fail((jqXHR, textStatus, errorThrown) => {

    });
}

function loadProducts() {
    $.ajax({
        url: '/products.json',
        type: 'GET'
    }).done(data => {
        renderProductTable(data);
    }).fail( (jqXHR, textStatus, errorThrown) => {
        displayAlert('alert-danger', 'We are sorry there was a problem.')
    });
}

function createProduct(productData) {
    $.ajax({
        url: '/products.json',
        type: 'POST',
        data: {product: productData}
    }).done(data => {
        renderProductTable([data]);
        $('#add-product')[0].reset();
        displayAlert('alert-success', 'Product Created!')
    }).fail((jqXHR, textStatus, errorThrown) => {
        displayAlert('alert-danger', 'We are sorry there was a problem.')
    });
}

function renderProductTable(products) {
    let html = '';
    products.forEach((v) => {
        html += '<tr>';
        html += `<td>${v.name}</td>`
        html += `<td>${v.type}</td>`
        html += `<td>${v.length}</td>`
        html += `<td>${v.width}</td>`
        html += `<td>${v.height}</td>`
        html += `<td>${v.weight}</td>`
        html += `<td><button data-id=${v._id.$oid} class="edit btn btn-small btn-info">Edit</button></td>`
        html += `<td><button data-id=${v._id.$oid} class="delete btn btn-small btn-danger">Delete</button></td>`
        html += '</tr>';
    });
    $('#product-table > tbody:last-child').append(html);
}

function destroy(productId, el) {
    $.ajax({
        url: `/products/${productId}.json`,
        type: 'DELETE'
    }).done(data => {
        $(el).closest("tr").remove();
        displayAlert('alert-success', 'Product Deleted!')
    }).fail((jqXHR, textStatus, errorThrown) => {
        displayAlert('alert-danger', 'We are sorry there was a problem.')
    });
}

function displayAlert(klass, message) {
    $('.alert').addClass(klass).text(message);
    $('.alert').show().delay(3000).fadeOut('slow');
    setTimeout( () => {
        $('.alert').removeClass(klass);
    }, 4000);
    $("html,body").animate({ scrollTop: 0 }, "slow");
}

function populateModalForm(productData) {
    $.each(productData, (k, v) => {
        if (k == '_id') {
            $('#edit-product').data('id', v.$oid);
        } else {
            $(`#edit-product :input[name=${k}]`).val(v);
        }
    });
}

function updateProduct(productData, productId) {
    $.ajax({
        url: `/products/${productId}.json`,
        type: 'PATCH',
        data: {product: productData}
    }).done(data => {
        $('#edit-modal').modal('toggle');
        alert('saved!');
    }).fail((jqXHR, textStatus, errorThrown) => {

    });
}

function parseFormData(id) {
    let formData = {};
    $(id).serializeArray().forEach(field => {
        formData[field.name] = field.value
    });
    return formData;
}