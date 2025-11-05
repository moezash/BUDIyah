import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Checkbox } from "@/components/ui/checkbox";
import { Mail, Lock, Eye, EyeOff, Wifi, Signal, Battery } from "lucide-react";

const Login = () => {
  const navigate = useNavigate();
  const [showPassword, setShowPassword] = useState(false);
  const [rememberMe, setRememberMe] = useState(false);

  return (
    <div className="min-h-screen relative overflow-hidden bg-[#FF9B9B]">
      {/* Status Bar */}
      <div className="absolute top-0 left-0 right-0 z-20 px-6 pt-3 flex justify-between items-center text-gray-900">
        <span className="text-sm font-semibold">9:41</span>
        <div className="flex items-center gap-1">
          <Signal className="w-4 h-4" />
          <Wifi className="w-4 h-4" />
          <Battery className="w-5 h-5" />
        </div>
      </div>

      {/* Organic topographic pattern background */}
      <div className="absolute inset-0 opacity-20">
        <svg className="w-full h-full" xmlns="http://www.w3.org/2000/svg">
          <defs>
            <pattern id="topographic-login" x="0" y="0" width="120" height="120" patternUnits="userSpaceOnUse">
              <path d="M20 60 Q35 40, 60 50 T100 60" stroke="rgba(255,255,255,0.4)" strokeWidth="2" fill="none"/>
              <path d="M15 75 Q30 60, 55 68 T95 78" stroke="rgba(255,255,255,0.4)" strokeWidth="2" fill="none"/>
              <path d="M25 90 Q40 75, 65 83 T105 93" stroke="rgba(255,255,255,0.35)" strokeWidth="1.5" fill="none"/>
              <circle cx="40" cy="85" r="18" stroke="rgba(255,255,255,0.35)" strokeWidth="2" fill="none"/>
              <circle cx="80" cy="30" r="25" stroke="rgba(255,255,255,0.35)" strokeWidth="2" fill="none"/>
              <ellipse cx="60" cy="100" rx="30" ry="18" stroke="rgba(255,255,255,0.35)" strokeWidth="1.5" fill="none"/>
            </pattern>
          </defs>
          <rect width="100%" height="100%" fill="url(#topographic-login)" />
        </svg>
      </div>

      {/* White curved section */}
      <div className="absolute top-[35%] left-0 right-0 bottom-0">
        <svg className="w-full h-full" viewBox="0 0 430 600" preserveAspectRatio="none">
          <path 
            fill="#ffffff" 
            d="M0,80 Q215,40 430,80 L430,600 L0,600 Z"
          />
        </svg>
      </div>

      {/* Content */}
      <div className="relative z-10 min-h-screen px-6 pt-20">
        <div className="max-w-md mx-auto w-full">
          <div className="mb-10">
            <h1 className="text-[32px] font-bold text-gray-900 mb-1.5">Masuk</h1>
            <div className="w-14 h-0.5 bg-primary rounded-full" />
          </div>

          <div className="space-y-6">
            {/* Email Input */}
            <div>
              <label className="block text-[15px] font-medium text-gray-700 mb-2">
                Email
              </label>
              <div className="relative flex items-center">
                <Mail className="absolute left-0 w-[18px] h-[18px] text-gray-400" />
                <Input
                  type="email"
                  placeholder="musagwanteng@gmail.com"
                  className="pl-7 pr-2 bg-transparent border-0 border-b border-primary/40 rounded-none focus:border-primary focus-visible:ring-0 focus-visible:ring-offset-0 text-[15px] placeholder:text-gray-400/60 h-9 pb-1.5"
                />
              </div>
            </div>

            {/* Password Input */}
            <div>
              <label className="block text-[15px] font-medium text-gray-700 mb-2">
                Password
              </label>
              <div className="relative flex items-center">
                <Lock className="absolute left-0 w-[18px] h-[18px] text-gray-400" />
                <Input
                  type={showPassword ? "text" : "password"}
                  placeholder="Masukkan Password Anda"
                  className="pl-7 pr-10 bg-transparent border-0 border-b border-primary/40 rounded-none focus:border-primary focus-visible:ring-0 focus-visible:ring-offset-0 text-[15px] placeholder:text-gray-400/60 h-9 pb-1.5"
                />
                <button
                  type="button"
                  onClick={() => setShowPassword(!showPassword)}
                  className="absolute right-0 text-gray-400 hover:text-gray-600 p-0.5"
                >
                  {showPassword ? <EyeOff className="w-[18px] h-[18px]" /> : <Eye className="w-[18px] h-[18px]" />}
                </button>
              </div>
            </div>

            {/* Remember Me & Forgot Password */}
            <div className="flex items-center justify-between pt-1">
              <div className="flex items-center gap-2">
                <Checkbox
                  id="remember"
                  checked={rememberMe}
                  onCheckedChange={(checked) => setRememberMe(checked as boolean)}
                  className="border-2 border-primary data-[state=checked]:bg-transparent data-[state=checked]:border-primary data-[state=checked]:text-primary w-[18px] h-[18px] rounded-[3px]"
                />
                <label
                  htmlFor="remember"
                  className="text-[14px] font-normal text-gray-700 cursor-pointer"
                >
                  Ingat Saya
                </label>
              </div>
              <button className="text-[14px] font-normal text-primary hover:text-primary/80">
                Lupa Password?
              </button>
            </div>

            {/* Login Button */}
            <Button
              className="w-full bg-primary hover:bg-primary/90 text-white rounded-[20px] py-6 text-[17px] font-medium shadow-md mt-14"
            >
              Login
            </Button>

            {/* Sign Up Link */}
            <p className="text-center text-[15px] text-gray-600 pt-2">
              Tidak punya akun?{" "}
              <button
                onClick={() => navigate("/signup")}
                className="text-primary font-semibold hover:text-primary/80"
              >
                Sign up
              </button>
            </p>
          </div>
        </div>

        {/* Bottom indicator */}
        <div className="flex justify-center mt-12 pb-3">
          <div className="w-32 h-1.5 bg-gray-900 rounded-full" />
        </div>
      </div>
    </div>
  );
};

export default Login;
