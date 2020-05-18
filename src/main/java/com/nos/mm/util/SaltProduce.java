package com.nos.mm.util;

import org.jasypt.salt.SaltGenerator;

public class SaltProduce implements SaltGenerator {

	@Override
	public byte[] generateSalt(int num) {
		return new byte[num];
	}

	@Override
	public boolean includePlainSaltInEncryptionResults() {
		return false;
	}

}
