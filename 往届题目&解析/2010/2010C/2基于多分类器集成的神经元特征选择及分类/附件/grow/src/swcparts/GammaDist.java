package swcparts;

import java.util.Random;

public class GammaDist { //from "Algorithm from Numerical Recipes in C", Second Ed.
     public double GetGammaAL(double a, double lambda, Random globalRand) {
          if (Double.isInfinite(a) || Double.isInfinite(a)) {
               System.out.println(
                      " Infinite input to GammaDist.  a = " + a + "  lambda = " + lambda);
               System.exit( -9);
          }

          double aa = -1.0, aaa = -1.0, b = 0, c = 0, d = 0, e = 0, r = 0, s = 0, si = 0, ss = 0,
                 q0 = 0,
                 q1 = 0.0416666664, q2 = 0.0208333723, q3 = 0.0079849875,
                 q4 = 0.0015746717, q5 = -0.0003349403, q6 = 0.0003340332,
                 q7 = 0.0006053049, q8 = -0.0004701849, q9 = 0.0001710320,
                 a1 = 0.333333333, a2 = -0.249999949, a3 = 0.199999867,
                 a4 = -0.166677482, a5 = 0.142873973, a6 = -0.124385581,
                 a7 = 0.110368310, a8 = -0.112750886, a9 = 0.104089866,
                 e1 = 1.000000000, e2 = 0.499999994, e3 = 0.166666848,
                 e4 = 0.041664508, e5 = 0.008345522, e6 = 0.001353826,
                 e7 = 0.000247453;

          double gds, p, q, t, sign_u, u, v, w, x;
          double v1, v2, v12;

          if (a <= 0.0) {
               return ( -1.0);
          }
          if (lambda <= 0.0) {
               return ( -1.0);
          }
          if (a < 1.0) { // CASE A: Acceptance rejection algorithm gs
               b = 1.0 + 0.36788794412 * a; // Step 1
               for (; ; ) {
                    p = b * globalRand.nextDouble();
                    if (p <= 1.0) { // Step 2. Case gds <= 1
                         gds = Math.exp(Math.log(p) / a);
                         if (Math.log(globalRand.nextDouble()) <= -gds) {
                              if (Double.isNaN(gds / lambda)) {
                                   System.out.println(
                                          "Gamma distribution function NaN error at point 1");
                                   System.exit(9);
                              }
                              return (gds / lambda);
                         }
                    }
                    else { // Step 3. Case gds > 1
                         gds = -Math.log( (b - p) / a);
                         if (Math.log(globalRand.nextDouble()) <= ( (a - 1.0) * Math.log(gds))) {
                              if (Double.isNaN(gds / lambda)) {
                                   System.out.println(
                                          "Gamma distribution function NaN error at point 2");
                                   System.exit(9);
                              }

                              return (gds / lambda);
                         }
                    }
               }
          }
          else { // CASE B: Acceptance complement algorithm gd
               if (a != aa) { // Step 1. Preparations
                    aa = a;
                    ss = a - 0.5;
                    s = Math.sqrt(ss);
                    d = 5.656854249 - 12.0 * s;
               }
               // Step 2. Normal deviate
               do {
                    v1 = 2.0 * globalRand.nextDouble() - 1.0;
                    v2 = 2.0 * globalRand.nextDouble() - 1.0;
                    v12 = v1 * v1 + v2 * v2;
               }
               while (v12 > 1.0);
               t = v1 * Math.sqrt( -2.0 * Math.log(v12) / v12);
               x = s + 0.5 * t;
               gds = x * x;
               if (t >= 0.0) {
                    if (Double.isNaN(gds / lambda)) {
                         System.out.println("Gamma distribution function NaN error at point 3.");
                         System.exit(9);
                    }
                    return (gds / lambda); // Immediate acceptance
               }

               u = globalRand.nextDouble(); // Step 3. Uniform random number
               if (d * u <= t * t * t) {
                    if (Double.isNaN(gds / lambda)) {
                         System.out.println("Gamma distribution function NaN error at point 4");
                         System.exit(9);
                    }
                    return (gds / lambda); // Squeeze acceptance
               }

               if (a != aaa) { // Step 4. Set-up for hat case
                    aaa = a;
                    r = 1.0 / a;
                    q0 = ( ( ( ( ( ( ( (q9 * r + q8) * r + q7) * r + q6) * r + q5) * r + q4) *
                              r + q3) * r + q2) * r + q1) * r;
                    if (a > 3.686) {
                         if (a > 13.022) {
                              b = 1.77;
                              si = 0.75;
                              c = 0.1515 / s;
                         }
                         else {
                              b = 1.654 + 0.0076 * ss;
                              si = 1.68 / s + 0.275;
                              c = 0.062 / s + 0.024;
                         }
                    }
                    else {
                         b = 0.463 + s - 0.178 * ss;
                         si = 1.235;
                         c = 0.195 / s - 0.079 + 0.016 * s;
                    }
               }
               if (x > 0.0) { // Step 5. Calculation of q
                    v = t / (s + s); // Step 6.
                    if (Math.abs(v) > 0.25) {
                         q = q0 - s * t + 0.25 * t * t + (ss + ss) * Math.log(1.0 + v);
                    }
                    else {
                         q = q0 + 0.5 * t * t * ( ( ( ( ( ( ( (a9 * v + a8) * v + a7) * v + a6) *
                                v + a5) * v + a4) * v + a3) * v + a2) * v + a1) * v;
                    } // Step 7. Quotient acceptance
                    if (Math.log(1.0 - u) <= q) {
                         if (Double.isNaN(gds / lambda)) {
                              System.out.println("Gamma distribution function NaN error at point 5");
                              System.exit(9);
                         }
                         return (gds / lambda);
                    }
               }
               for (; ; ) {

                    // Step 8. Double exponential deviate t
                    do {
                         e = -Math.log(globalRand.nextDouble());
                         u = globalRand.nextDouble();
                         u = u + u - 1.0;
                         sign_u = (u > 0) ? 1.0 : -1.0;
                         t = b + (e * si) * sign_u;
                    }

                    while (t <= -0.71874483771719); // Step 9. Rejection of t
                    v = t / (s + s); // Step 10. New q(t)
                    if (Math.abs(v) > 0.25) {
                         q = q0 - s * t + 0.25 * t * t + (ss + ss) * Math.log(1.0 + v);
                    }
                    else {
                         q = q0 + 0.5 * t * t * ( ( ( ( ( ( ( (a9 * v + a8) * v + a7) * v + a6) *
                                v + a5) * v + a4) * v + a3) * v + a2) * v + a1) * v;
                    }
                    if (q <= 0.0) {
                         continue; // Step 11.
                    }
                    if (q > 0.5) {
                         w = Math.exp(q) - 1.0;
                    }
                    else {
                         w = ( ( ( ( ( (e7 * q + e6) * q + e5) * q + e4) * q + e3) * q + e2) *
                              q + e1) * q;
                    } // Step 12. Hat acceptance
                    if (c * u * sign_u <= w * Math.exp(e - 0.5 * t * t)) {
                         x = s + 0.5 * t;
                         if (Double.isNaN(x * x / lambda)) {
                              System.out.println("Gamma distribution function NaN error at point 6");
                              System.exit(9);
                         }

                         return (x * x / lambda);
                    }
               }
          }
     }

     public double GetGammaAB(double alpha, double beta, Random globalRand) {
          double lambda = 1 / beta;
          return GetGammaAL(alpha, lambda, globalRand);

     }

     public double GetGammaMS(double mean, double stdev, Random globalRand) {
          if (stdev <= 0) {
               return mean;
          }
          double variance = stdev * stdev;
          double lambda = 1 / (variance / mean);
          double alpha = mean * mean / variance;
          return GetGammaAL(alpha, lambda, globalRand);
     }

      public static int getCurveType(double[] realData, int length, Random globalRand) {
            // return 1; /*temp
          if (length <= 2) {
            //   System.out.println("  length less than 2");
               return 1;
          }

          double[] uniformToTest = new double[length+1];
          double[] gaussianToTest = new double[length+1];
          double[] gammaToTest = new double[length+1];

          GammaDist gd = new GammaDist();

          double uniformDiff = 0;
          double gammaDiff = 0;
          double gaussianDiff = 0;

          double realMin = realData[1];
          double realMax = 0;
          double realStdev = 0;
          double realMean = 0;
          double realSymetricMax = 0;
          double realSum = 0;
          double diffSqSum = 0;
          for (int i = 1; i <= length; i++) { //for each array element
               realSum += realData[i]; //find sum
               if (realMax < realData[i]) { //find max
                    realMax = realData[i];
               }
               if (realMin > realData[i]) { //find min
                    realMin = realData[i];
               }
          }

    java.util.Arrays.sort(realData,1,length+1);
          if (realMin == realMax) {
            //    System.out.println("  min = max");
               return 1;
          }
           realMean = realSum / length;
          if ( (realMin >= realMean) || (realMax <= realMean)) {
               System.out.println(
                      "mean in  function getCurveType is outside range, possible infinite loop.  Min, Mean, Max: " +
                      realMin + "  " + realMean + "  " + realMax);
               System.exit(11);
          }

          //find stdev of real data
          for (int i = 1; i <= length; i++) {
               diffSqSum += ( (realData[i] - realMean) * (realData[i] - realMean));
          }
          if ( (diffSqSum == 0) || (length <= 2)) {
               realStdev = 0;
          }
          else {
               realStdev = java.lang.Math.sqrt(diffSqSum / (length - 1));
          }
          if (realStdev <= 0) {
              // System.out.println("  stdev less than 0");
               return 1;
          }
          realSymetricMax = ( (realMean * 2) - realMin);
          //populate three new double arrays with sampled data, sort them
          for (int i = 1; i <= length; i++) {
               //uniform
               uniformToTest[i] = (globalRand.nextDouble() * (realSymetricMax - realMin) + realMin);
               //gaussian
               gaussianToTest[i] = realMin - 1;
               while ( (gaussianToTest[i] < realMin) || (gaussianToTest[i] > realSymetricMax)) {
                    gaussianToTest[i] = (globalRand.nextGaussian() * realStdev) + realMean;
               }
               //gamma
               gammaToTest[i] = realMin - 1;
               while ( (gammaToTest[i] < realMin) || (gammaToTest[i] > realMax)) {
                    gammaToTest[i] = (gd.GetGammaMS(realMean, realStdev, globalRand));
               }
          }
          java.util.Arrays.sort(uniformToTest,1,length+1);
          java.util.Arrays.sort(gaussianToTest,1,length+1);
          java.util.Arrays.sort(gammaToTest,1,length+1);
          //find least mean squares between real and sampled
          for (int i = 1; i < length; i++) {
               uniformDiff += ( (realData[i] - uniformToTest[i]) * (realData[i] - uniformToTest[i]));
               gaussianDiff +=
                      ( (realData[i] - gaussianToTest[i]) * (realData[i] - gaussianToTest[i]));
               gammaDiff += ( (realData[i] - gammaToTest[i]) * (realData[i] - gammaToTest[i]));
          }


          if (uniformDiff < gaussianDiff) {
               if (uniformDiff < gammaDiff) {
                    return 1;
               }
               else {
                    return 3;
               }
          }
          else if (gammaDiff < gaussianDiff) {
               return 3;
          }
          else {
               return 2;
          }//*/
     }

     //takes in the mean, and stdev so they don't have to be computed again
   // static public int getCurveType(double[] realData, int length, double realMean, double realStdev,
   //                          Random globalRand) {




}
