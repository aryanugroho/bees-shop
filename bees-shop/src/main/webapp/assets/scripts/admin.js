var beesden = beesden || {};

beesden.menu = function(a) {
	return{init:function() {
		a(".menu ul").siblings("a").click(function(b) {
			$current = a(this).siblings("ul");
			a(".menu ul").not($current).delay(100).slideUp(250);
			a(this).siblings("ul").delay(200).slideToggle(250);
			b.preventDefault();
		});
		var c = a(".left-items .options a");
		c.click(function(b) {
			a(this).hasClass("parent") ? (c.not(a(this)).siblings("ul").delay(100).slideUp(250), a(this).siblings("ul").delay(200).slideToggle(250), b.preventDefault()) : a(this).hasClass("submit") && (b = a(this).closest("form"), b.find("#statusUpdate").val(a(this).text()), b.submit());
		});
		var d = a(".left-items .check input");
		d.change(function() {
			d.is(":checked") ? (a(".left-items .options .create").hide(), a(".left-items .options .update").show()) : (a(".left-items .options .create").show(), a(".left-items .options .update").hide());
		});
		a(".form").click(function() {
			var b = a(this).attr("href") + " #formView";
			a(".form").removeClass("active");
			a(this).addClass("active");
			a(".form-space").addClass("pageFormLoading");
			a("#formView").remove();
			a(".form-space").load(b, function() {
				beesden.inputs.init();
				beesden.plugins.init();
				beesden.googlemaps.init();
				a(".form-space").removeClass("pageFormLoading").hide().fadeIn(600);
			});
			return!1;
		});
	}};
}(jQuery);

beesden.inputs = function(a) {
	return{init:function() {
		var c = a(".ckedit", "#formView");
		c.length && a.getScript(CKEDITOR_BASEPATH + "ckeditor.js", function() {
			c.each(function() {
				var i = a(this).attr("name");
				CKEDITOR.replace(i);
			})
		});
		var b = $(".date");
		b.length && b.datepicker({dateFormat:"dd-mm-yy", gotoCurrent:!0, showOn:"both"});
		var f = $(".parentSelect");
		if(f.length) {
			var g = function() {
				f.each(function() {
					var a = $(this).find("select").val(), b = $(this).siblings(".childSelect");
					b.find(".child").hide();
					b.find(".item-" + a).fadeIn(300)
				})
			};
			f.find("select").change(function() {
				g()
			});
			g()
		}
		var multiple = $('select.multiple');
		if (multiple.length) {
			a.getScript(t + "/assets/scripts/plugin/jquery.multi-select.js", function() {
				multiple.multiSelect({
				  selectableHeader: '<span class="ms-header">Available</span>',
				  selectionHeader: '<span class="ms-header">Selected</span>'
				});
			})
		}
	}};
}(jQuery);

beesden.googlemaps = function($) {
	return{init:function() {
		$('#updateMap').click(function(e) {	
			var mapLat = $('#geoLat'), mapLng = $('#geoLng'), postcode = $('#postcode');
			$('#addressMap').dialog({
				modal: true, width:500, height:500, close: function() {
					$('#geoLat').val(mapLat);
					$('#geoLng').val(mapLng);					
				}
			});
			e.preventDefault();			
			
			var	bounds = new google.maps.LatLngBounds(),
			loc,
			mapOptions = { mapTypeId: google.maps.MapTypeId.ROADMAP, zoom:16 },	
			map = new google.maps.Map(document.getElementById("addressMap"), mapOptions),
			geocoder = new google.maps.Geocoder();		       

			if (mapLat.val() == null || mapLng.val() == null) {
				geocoder.geocode( { 'address': postcode.value}, function(results, status) {
		          if (status == google.maps.GeocoderStatus.OK) {
		            map.setCenter(results[0].geometry.location);
		            var marker = new google.maps.Marker({
		                map: map,
		                center: results[0].geometry.location,
		                position: results[0].geometry.location,
		                draggable: true
		            });
					mapLat = results[0].geometry.location.lat();
					mapLng = results[0].geometry.location.lng();
		          } else {
		            alert('Geocode was not successful for the following reason: ' + status);
		          }
		        });
			} else {
				loc = new google.maps.LatLng(mapLat.val(), mapLng.val());
				map.setCenter(loc);
				var marker = new google.maps.Marker({
					position: loc,
					map: map,
				    draggable: true
				});
			}	
			  mapLat = marker.getPosition().lat();
			  mapLng = marker.getPosition().lng();
			
			  google.maps.event.addListener(marker, 'dragend', function() {
				  mapLat = marker.getPosition().lat();
				  mapLng = marker.getPosition().lng();
			  });
		});
	}}
}(jQuery);

beesden.plugins = function(a) {
	return{init:function() {
		var h = $(".nestable"), d = a(".dropList dt", "#formView");
		h.length && (a.getScript(t + "/assets/scripts/plugin/jquery.nestable.js", function() {
			h.nestable({maxDepth:1});
			$("#addPage").change(function() {
				var a = $(":selected", "#addPage"), a = $('"\x3cli data-id\x3d"' + a.val() + '"\x3e\x3cdiv class\x3d"dd-handle"\x3e' + a.text() + "\x3c/div\x3e\x3c/li\x3e");
				$("#pageList").prepend(a);
				$("#addPage").val(0)
			})
		}), $("#menuForm").submit(function() {
			var a = [], b = $("li", "#menuPages"), c = 1;
			$.each(b, function() {
				$(this).attr("data-parent", c);
				var b = 0, d = $(this).data("id"), e = $(this).closest(".nestable").data("type");
				$(this).parent().hasClass("nestable") || (b = $(this).parents("li").data("parent"));
				0 != d && (a.push({id:c, pageIndex:c, pageParent:b, pageType:e, pageId:d}), c++)
			});
			$.ajax({type:"POST", url:"admin/menu", data:JSON.stringify(a), dataType:"json", contentType:"application/json", success:function() {
				window.location.href = t + "/admin/adm_configList"
			}});
			return!1
		}));
		d.click(function() {
			a(this).toggleClass("active");
			d.not(a(this)).siblings("dd").slideUp();
			a(this).siblings("dd").slideToggle()
		});
		var e = a("#albumImages");
		$("#albumUpload").length && a.getScript("/assets/scripts/plugin/jquery.albumupload.js");
		e.find("div").length && (e.sortable({tolerance:"pointer", update:function() {
			var b = 1;
			b.find("div").each(function() {
				a(this).find(".position").attr("value", b);
				b++
			})
		}}), a("#save").click(function(b) {
			$removeImages = e.find(".remove:checked");
			e.find(".remove:checked").length && ($checkForm = a(this).closest("form"), $("body").css("overflow", "hidden"), b.preventDefault(), a('\x3cdiv class\x3d"alert"\x3e').text("Are you sure you want to remove the selected items?").dialog({modal:!0, resizable:!1, minHeight:0, buttons:{confirm:function() {
				a(this).dialog("close");
				$("body").css("overflow", "auto");
				$checkForm.submit()
			}, cancel:function() {
				a(this).dialog("close");
				$("body").css("overflow", "auto");
				return!1
			}}}))
		}))
		var products = a("#categoryProducts");
		if (products.length) {
			function postList(data) {	
				$.each(data, function(index) {
					console.log(data[index])
					$.ajax( {
					type: 'POST',
					url: 'admin/categoryUpdate',
					data: data[index],
				    success: function(data) {
				    	var pasta = $('<div>'), products = $('#category-products');
				    	products.parent().load('/admin/category?id=' + $('#id').val() + ' #category-products');
				    	products.append(pasta.html());
				    }
				})
			});								
			}
			products.find("#addProduct").change(function() {			
				var value = $(this).val();
				if (value != '') {			
					var data = [];
					data.push({categoryId : $('#id').val(), productId : value, updateType : "0"});
					postList(data);
				}
				$(this).find('option[value=' + value + ']').remove();
				$(this).val('');
			})
			products.find("#updateProducts").change(function() {	
				var cobra = $(this),data = [];
				if (cobra.val() != '') {
				$('.product-select:checked', '#category-products').each(function() {
						data.push({categoryId : $('#id').val(), productId : $(this).val(), updateType : cobra.val()});
					
				})
			}
				postList(data);
				cobra.val('');
				});
		}
	}};
}(jQuery);

$(document).ready(function() {
	t = $("#pageUrl").val();
	CKEDITOR_BASEPATH = t + "/assets/ckeditor/";
	beesden.menu.init();
	beesden.googlemaps.init();
	beesden.inputs.init();
	beesden.plugins.init();
});