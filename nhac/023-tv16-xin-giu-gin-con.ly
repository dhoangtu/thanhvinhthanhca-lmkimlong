% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Xin Giữ Gìn Con" }
  composer = "Tv. 16"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4 \tuplet 3/2 { g8 g g } |
  e4. d8 |
  b'4 \tuplet 3/2 { b8 c a } |
  b8. a16 \tuplet 3/2 { d8 b g } |
  e4 r8 e16 \slashedGrace { e16 ( } fs) |
  e8 d g fs16 (g) |
  \slashedGrace { b16 ( } a4.) c16 b |
  a8 d d d |
  g,4 \bar "||" \break
  
  \tuplet 3/2 { d'8 e b } |
  c8. c16 \tuplet 3/2 { c8 c d } |
  d4 \tuplet 3/2 { c8 c a } |
  b8. c16 \tuplet 3/2 { c8 c a } |
  g4 \tuplet 3/2 { g8 e g } |
  a8. g16 \tuplet 3/2 { a8 a b } |
  d,4 \tuplet 3/2 { d8 c' b } |
  a8. c16 \tuplet 3/2 { d8 fs, g } |
  g4 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  r4 |
  R2*7
  r4
  \tuplet 3/2 { b8 c g } |
  a8. a16 \tuplet 3/2 { a8 a g } |
  fs4 \tuplet 3/2 { a8 a fs } |
  g8. a16 \tuplet 3/2 { a8 a fs } |
  g4 \tuplet 3/2 { g8 e g } |
  d8. e16 \tuplet 3/2 { d8 d c } |
  b4 \tuplet 3/2 { b8 e g } |
  fs8. e16 \tuplet 3/2 { d8 d c } |
  b4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Con kêu lên Ngài,
      lạy Chúa thương đáp lời con,
      xin nghe tiếng con cầu,
      Xin biểu lộ tình thương của Chúa,
      cứu ai tìm nép bóng cánh Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Nơi tôn nhan Ngài,
	    nguyện Chúa soi thấu hồn con.
	    con luôn sống trung thực
	    Ngay giữa đêm trường đem xử xét
	    cũng không hề thấy chút ác tà.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Con không theo đòi người thế ăn nói đảo điên,
	    nhưng theo Chúa chỉ dậy
	    Luôn tránh xa đường quân tội lỗi,
	    Quyết theo đường lối Chúa vững bền.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Con luôn trung thành gìn giữ
	    cho suốt đời con luôn công chính ngay thực
	    Con sẽ được nhìn dung mạo Chúa,
	    sớm mai vừa thức đã thấy Ngài.
    }
  >>
  \set stanza = "ĐK:"
  Xin giữ gìn con như con ngươi mắt Chúa,
  Xin che chở con dưới bóng cánh tay Ngài,
  Xin bảo vệ con khỏi quân gian ám hại,
  khỏi lũ quân thù đang xiết vòng vây con.
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  page-count = 1
}

TongNhip = {
  \key g \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #0.6
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
