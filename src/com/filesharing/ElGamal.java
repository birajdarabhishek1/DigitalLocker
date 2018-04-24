
package com.filesharing;

import java.math.BigInteger;
import java.util.Random;
import java.io.*;

public class ElGamal {

	public static BigInteger[] encrypt(BigInteger m, BigInteger p, BigInteger b, BigInteger g) {

		BigInteger[] rtn = { null, null };
		BigInteger k = ElGamal.getRandomk(p);

		BigInteger C1 = g.modPow(k, p);
		BigInteger C2 = m.multiply(b.modPow(k, p)).mod(p);

		rtn[0] = C1;
		rtn[1] = C2;
		return rtn;
	}

	public static BigInteger getRandomk(BigInteger p) {

		Random r = new Random(); // value in the range 0.0 to 1.0
		BigInteger k = null;
		while (true) {
			k = new BigInteger(p.bitLength() - 1, r);
			if (k.gcd(p.subtract(BigInteger.ONE)).equals(BigInteger.ONE)) {
				break;
			}
		}
		return k;
	}

	public static BigInteger[] getRandomP(int alpha) {
		BigInteger rtn[] = { null, null };
		Random r = new Random();
		BigInteger p = null;
		BigInteger q = null;

		while (true) {
			q = BigInteger.probablePrime(alpha, r);//
			if (q.bitLength() != alpha) //
				continue;
			if (q.isProbablePrime(10)) {
				p = q.multiply(new BigInteger("2")).add(BigInteger.ONE);
				if (p.isProbablePrime(10))
					break;
			}
		}

		BigInteger g = null;
		while (true) {
			g = BigInteger.probablePrime(p.bitLength() - 1, r);// new
																// BigInteger(p.bitLength()-1,r);
			if (!g.modPow(BigInteger.ONE, p).equals(BigInteger.ONE) && !g.modPow(q, p).equals(BigInteger.ONE)) {
				break;
			}
		}
		rtn[0] = p;
		rtn[1] = g;
		return rtn;
	}

	public static BigInteger getRandoma(BigInteger p) {
		BigInteger a = null;
		Random r = new Random();
		a = new BigInteger(p.bitLength() - 1, r);
		return a;
	}

	public static BigInteger calculateb(BigInteger g, BigInteger a, BigInteger p) {
		BigInteger b = null;
		b = g.modPow(a, p);

		return b;
	}

	public static BigInteger decrypt(BigInteger C1, BigInteger C2, BigInteger a, BigInteger p) {
		BigInteger m = null;
		m = C2.multiply(C1.modPow(a.negate(), p)).mod(p);
		return m;
	}

	public static BigInteger[] encryptSignature(String m, BigInteger p, BigInteger b, BigInteger g) {

		BigInteger[] rtn = { null, null };
		BigInteger message = new BigInteger(m.getBytes());// plain text data
		rtn = ElGamal.encrypt(message, p, b, g);

		return rtn;
	}

	public static String decryptSignature(BigInteger C1, BigInteger C2, BigInteger a, BigInteger p) {
		String str = "";
		try {
			BigInteger rtn = ElGamal.decrypt(C1, C2, a, p);
			str = new String(rtn.toByteArray());
		} catch (Exception ex) {

		}

		return str;
	}

}