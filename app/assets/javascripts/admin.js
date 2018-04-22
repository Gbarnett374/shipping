$(document).ready(() => {
    $('.alert').hide();
    loadProducts();

    $('#add-product').submit(e => {
        e.preventDefault();
        createProduct();
    });
});
// Need these for delete & edit events since we are building the table via ajax.
$(document).on('click', '.delete', function(e) {
    let id = $(this).data('id');
    let el = $(this);
    destroy(id, el);
});

$(document).on('click', '.edit', function (e) {
    let id = $(this).data('id');
    alert(id);
});
// ********

function loadProducts() {
    $.ajax({
        url: '/products.json',
        type: 'GET',
    }).done(data => {
        renderProductTable(data);
    }).fail(data => {
        displayAlert('alert-danger', 'We are sorry there was a problem.')
    });
}

function createProduct(e) {
    let formData = $('#add-product').serializeArray();
    let postData = {};
    formData.forEach((field) => {
        postData[field.name] = field.value
    });

    $.ajax({
        url: '/products.json',
        type: 'POST',
        data: {product: postData}
    }).done(data => {
        renderProductTable([data]);
        $('#add-product')[0].reset();
        displayAlert('alert-success', 'Product Created!')
    }).fail(data => {
        displayAlert('alert-danger', 'We are sorry there was a problem.')
    });
}

function renderProductTable(products) {
    let html = '';
    products.forEach( (v, k) => {
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

function destroy(product_id, el) {
    $.ajax({
        url: `/products/${product_id}.json`,
        type: 'DELETE'
    }).done(data => {
        $(el).closest("tr").remove();
        displayAlert('alert-success', 'Product Deleted!')
    }).fail(data => {
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