/** cart.jsp의 cartItemList가 비어있지 않다면 불러오는 js파일.
 * 
 */

const clientKey = "test_ck_jExPeJWYVQlOdp6pRbQ349R5gvNL";
const customerKey = self.crypto.randomUUID(); // 내 상점에서 고객을 구분하기 위해 발급한 고객의 고유 ID
const paymentWidget = PaymentWidget(clientKey, customerKey); // 회원 결제

function delCartItem(delCartItemRequest, CartItemMap) {
			const data = JSON.stringify({
				  member_id: jstlMemberId,
				  checked_cart_item_list: Array.from(CartItemMap.keys())
				});
			console.log(data, typeof(data));
			delCartItemRequest.open("POST", jstlContextPath+"/Cart/delCartItem.do");
			delCartItemRequest.setRequestHeader("Content-Type", "application/json");
		    delCartItemRequest.responseType="json";
		    delCartItemRequest.send(data);
	    }

	    window.onload = function () {
	    	var delCartItemRequest = new XMLHttpRequest();
	    	delCartItemRequest.onreadystatechange = function () {
			    var result = this.response;
			    if(this.readyState == this.DONE) {
			    	console.log(result);
			    	console.log(this.getAllResponseHeaders());
			    	alert("제거되었습니다.");
			    	window.location.reload("true");
			    } else {
			    	console.log(this.readyState);
			    	console.log(result);
			    }
		    };
		    
		    var paymentMethodWidget = null;
		    var paydiv = document.getElementById('payment-div');
		    var paybtn = document.getElementById('payment-btn');
	    	var cmdbtn = document.getElementById('chosen-song-del-btn');
	    	var cmbbtn = document.getElementById('chosen-song-buy-btn');
	    	var ambbtn = document.getElementById('all-song-buy-btn');
	      	var cart_items = document.querySelectorAll("div.cart-item");
	    	var total_payment = document.getElementById('total-payment');
	    	var cart_item_all_check = document.getElementById('check-all');
			
	    	var CartItemMap = new Map();
	    	paydiv.style.visibility = 'hidden';
	    	
	    	paybtn.addEventListener('click', function(event) {
	    		paymentMethodWidget.updateAmount(parseInt(total_payment.innerText));
	    		if(CartItemMap.size < 1) {
	    			alert('선택된 음원이 없습니다.');
	    			return;
	    		}
	    		const map1stIter = CartItemMap.values().next();
	  			console.log(map1stIter.value[0].song_name);
	    		let orderId = self.crypto.randomUUID();
	    		let orderName = (CartItemMap.size > 1) ? (map1stIter.value[0].song_name+" 외 "+(CartItemMap.size-1)+"건") :map1stIter.value[0].song_name;
	    		let escrowProducts = new Array();
	    		let keyIterList = CartItemMap.keys();
	    		let cartItemIds = "";
	    		for(let key of keyIterList) {
	    			cartItemIds += (key+",");
	    		}
	    		cartItemIds = cartItemIds.slice(0, -1);
	    		console.log("cartItemIds: "+cartItemIds);
	    		CartItemMap.forEach(function(cartItem) {
	    			escrowProducts.push({
		    			id: cartItem[0].song_id,
		    			name: cartItem[0].song_name,
		    			code: cartItem[0].song_id,
		    			unitPrice: cartItem[0].song_price,
		    			quantity: 1
		    		});	
	    		})
	    		console.log(escrowProducts);
	    		paymentWidget
			   		.requestPayment({
				        orderId: orderId,            // 주문 ID(직접 만들어주세요)
				        orderName: orderName,                 // 주문명
				        successUrl: "http://localhost:8060/"+jstlContextPath+"/Cart/impTest/success/cartItemPayment.do?cartItemIds="+cartItemIds,  // 결제에 성공하면 이동하는 페이지(직접 만들어주세요)
				        failUrl: "http://localhost:8060/"+jstlContextPath+"/impTest/fail.jsp",        // 결제에 실패하면 이동하는 페이지(직접 만들어주세요)
				        customerName: jstlMemberName,
				        escrowProducts: escrowProducts
			      	})
			      	.catch(function (error) {
					    if (error.code === 'INVALID_ORDER_NAME') {
					      	// 유효하지 않은 'orderName' 처리하기
					      	console.log(error.code);
					    } else if (error.code === 'INVALID_ORDER_ID') {
					      	// 유효하지 않은 'orderId' 처리하기
					      	console.log(error.code);
					    } else {
					    	console.log(error.code);
					    }
			  	  	})
	      		const selectedPaymentMethod = paymentMethodWidget.getSelectedPaymentMethod();
	      		console.log(selectedPaymentMethod);
	    	});
	    	
	    	cmdbtn.addEventListener('click', function(event) {
	    		if(CartItemMap.size > 0) {
	    			var message = "선택된 "+CartItemMap.size+"개의 음원을 장바구니에서 제거하시겠습니까?";
		    		if(confirm(message)) {
		    			delCartItem(delCartItemRequest, CartItemMap);	
		    		}	
	    		} else {
	    			alert("선택된 음원이 없습니다.");
	    		}
	    	});
	    	
	    	
	    	cart_item_all_check.addEventListener('change', function(event) {	//전체 선택 체크박스 이벤트 할당
	    		cart_items.forEach(function(cart_item) {
	    			var cart_item_checkbox = cart_item.getElementsByClassName("cart-item-checked")[0];
	    			if(cart_item_all_check.checked && !cart_item_checkbox.checked) {
	    			  	cart_item_checkbox.click();  
	    		  	} else if(!cart_item_all_check.checked) {
	    		  	  	cart_item_checkbox.click();
	    		  	}
	    		});
	    	});
	  	  
	  	  	console.log(cart_items);
	  	  	
	  	  	cart_items.forEach(function(cart_item) {
	  		  	var cart_item_checkbox = cart_item.getElementsByClassName("cart-item-checked")[0];
	  		 	console.log(cart_item_checkbox);
	  		 	var cart_item_price = cart_item.getElementsByClassName("cart-item-price")[0].innerText;
	  		  	var cart_item_name = cart_item.getElementsByClassName("cart-item-song-name")[0].innerText;
	  		 	
	  		  	cart_item_price = parseInt(cart_item_price);
	  		  
	  		  	cart_item_checkbox.addEventListener('change', function (event){	//각 체크박스마다 이벤트 할당
	  				console.log(event.target.checked);
	  				if(event.target.checked) {
	  					CartItemMap.set(cart_item_checkbox.id ,[{song_id: cart_item_checkbox.id, song_name: cart_item_name, song_price: cart_item_price}]);
	  					console.log(CartItemMap);
	  					
	  					if(isAllChecked(cart_items)) {
	  						cart_item_all_check.checked = event.target.checked;
	  					}
	  					total_payment.innerText = parseInt(total_payment.innerText) + cart_item_price;
	  				} 
	  				else {
	  					console.log("[Before Delete] CartItemMap.has("+cart_item_checkbox.id+"): "+CartItemMap.has(cart_item_checkbox.id));
	  					if(CartItemMap.has(cart_item_checkbox.id)) {
	  						CartItemMap.delete(cart_item_checkbox.id);
	  						console.log(CartItemMap);
	  					}
	  					console.log("[After Delete] CartItemMap.has("+cart_item_checkbox.id+"): "+CartItemMap.has(cart_item_checkbox.id));
	  					cart_item_all_check.checked = event.target.checked;
	  					total_payment.innerText = parseInt(total_payment.innerText) - cart_item_price;
	  				}
	  				console.log("[Result] CartItemMap.has("+cart_item_checkbox.id+"): "+CartItemMap.has(cart_item_checkbox.id));
	  		  	});
	  	  	});
	  	  
	  	  	cmbbtn.addEventListener('click', function(){
				if(CartItemMap.size == 0) {
					alert("선택된 음원이 없습니다");
					return;
				}
	  	  		paymentMethodWidget = paymentWidget.renderPaymentMethods("#payment-method", { value: 0 }); //가격은 결제 버튼을 누른 순간 정해진다. 78줄 참조
	  	  		const paymentAgreement = paymentWidget.renderAgreement('#agreement');
			  	if(paymentAgreement.getAgreementStatus().agreedRequiredTerms && paydiv.style.visibility == 'hidden') {
			  		paydiv.style.visibility = 'visible';
			  	}
	  	  	});
	  	  	
	  	  	ambbtn.addEventListener('click', function(){
	  			cart_item_all_check.click(); //전체 선택
	  			paymentMethodWidget = paymentWidget.renderPaymentMethods("#payment-method", { value: 0 }); //가격은 결제 버튼을 누른 순간 정해진다. 78줄 참조
	  	  		const paymentAgreement = paymentWidget.renderAgreement('#agreement');
			  	if(paymentAgreement.getAgreementStatus().agreedRequiredTerms && paydiv.style.visibility == 'hidden') {
			  		paydiv.style.visibility = 'visible';
			  	}
		  	});
	  	}
		function isAllChecked(cart_item_list) {
			cart_item_list = Array.from(cart_item_list); //NodeList에는 some 함수가 없어서 Array로 바꿔야했음
			var is_all_checked = true;
			console.log(cart_item_list);
			
			cart_item_list.some(function (cart_item) {	//한 번이라도  true를 리턴하면 멈추는 함수 some
														
				var cart_item_checked = cart_item.getElementsByClassName("cart-item-checked")[0].checked;
				if(!cart_item_checked) {
					is_all_checked = false;
					return true; //체크가 안되어있는 체크박스가 있는 경우 true 리턴 == 전체 선택이 되어있지 않은 상태
				}
			});
			console.log("is all checked: "+ is_all_checked);
			return is_all_checked;
		}
		function limitPlayTime(audio) {
	        if (audio.currentTime > 60) { // 1분(60초)로 제한
	            audio.pause();
	            audio.currentTime = 0; // 음악이 끝난 후 처음으로 돌아감
	            alert("1분 미리듣기가 종료되었습니다.");
	        }
	    } 