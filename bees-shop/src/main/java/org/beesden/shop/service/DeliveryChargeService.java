package org.beesden.shop.service;

import org.beesden.shop.model.DeliveryCharge;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
public class DeliveryChargeService extends Service<DeliveryCharge> {

	public DeliveryChargeService() {
		super(DeliveryCharge.class.getName());
	}
}
