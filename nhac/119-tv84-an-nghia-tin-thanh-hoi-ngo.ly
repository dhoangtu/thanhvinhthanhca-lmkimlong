% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Ân Nghĩa Tín Thành Hội Ngộ" }
  composer = "Tv. 84"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 d8 |
  d (b16 a) e8 g |
  a8. b16 g8 e |
  d4. d8 |
  g8 fs g (a) |
  b8. g16 c8 b |
  a4 r8 b |
  c8. a16 a8 a16 (c) |
  d4 b16 (a) d8 |
  fs,8. a16 d8 a |
  g4 r8 \bar "||"
  
  b |
  d4. b16 (a) |
  g8
  \afterGrace a4 ({
    \override Flag.stroke-style = #"grace"
    g8)}
  \revert Flag.stroke-style
  e8 |
  e4 r8 d |
  d4. fs8 |
  a a4 g8 |
  g4 r8 b |
  g4. g8 |
  c a4 c8 |
  d4. a8 |
  b4. b8 |
  e, e4 d8 |
  g2 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  r8 |
  R2*9
  r4.
  g8 |
  b4. g8 |
  e d4 d8 |
  c4 r8 c |
  b4. d8 |
  cs d4 d8 |
  b4 r8 g' |
  e4. d8 |
  e fs4 a8 |
  b4. fs8 |
  g4. e8 |
  c c4 c8 |
  b2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Chúa đã tỏ lòng thương thánh địa của Ngài,
      tù nhân nhà Gia -- cóp Ngài dẫn đưa về,
      tha thứ tội vạ của dân,
      bao lỗi lầm cũng phủ lấp đi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chúa nỡ giận khôn thôi,
	    cứ nổi lôi đình,
	    nài xin Ngài thương dẫn đường chúng con đi,
	    dân Chúa lại được mừng vui
	    bởi Chúa đã cứu độ chúng con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Chúa sẵn sàng ban ơn cứu độ dân Ngài,
	    và ai hằng trung hiếu Ngài chúc an vui,
	    vinh hiển Ngài hằng tỏa sáng
	    trên khắp cả lãnh địa chúng con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chính Chúa đà tặng ban phúc lộc chan hòa,
	    và hoa mầu xanh tốt rợp đất chúng ta,
	    công lý mở đường đi trước
	    khai lỗi để Chúa tiến bước qua.
    }
  >>
  \set stanza = "ĐK:"
  Ân nghĩa, tín thành nay hội ngộ
  Hòa bình, công lý đã giao duyên.
  Tín thành mọc lên từ đất thấp,
  Công lý đoái lại tự trời cao
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
