% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Lời Chúa Lời Chân Thành" }
  composer = "Tv. 11"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 d8 |
  bf'4. a16 bf |
  a4. f!?8 |
  f8. f16 g8 a |
  d,4 ef8 c |
  c4. d8 |
  bf'8. a16 fs (g) a8 |
  g2 ~ |
  g4 r8 \bar "||"
  
  d8 |
  bf'4. g16 a |
  d,4. g8 |
  ef8. ef16 ef8 g |
  a4 r8 g |
  c8. c16 bf8 c |
  d4. d16 c |
  bf8. d,16 \tuplet 3/2 { a'8 a bf } |
  g2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Lạy Chúa, xin cứu nguy,
      vì nào còn ai đức độ,
      Giữa loài người nào thấy đâu kẻ tín trung,
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Lời chúng luôn dối gian,
	    lòng một dạ hai phỉnh phờ.
	    Lưỡi ngạo ngược,
	    Cầu Chúa tru diệt chúng đi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Bọn chúng khoe với nhau:
	    mình mạng nhờ môi mép này,
	    Có người nào hòng nói qua được chúng ta?
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Nhìn mãi bao bất công,
	    người nghèo hèn rên xiết hoài,
	    Chúa vùng dậy giải thoát bao kẻ ngóng trông.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Lạy Chúa, xin đứng lên,
	    bảo vệ đoàn con thoát nạn,
	    Lũ bạo tàn mặc sức tung hoành khắp nơi.
    }
  >>
  \set stanza = "ĐK:"
  Lời Chúa, lời chân thành như bạc luyện lọc tinh anh,
  Ngài luôn trung thành ghi nhớ,
  cứu chúng con khỏi tay quân ác thù.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2))
}

TongNhip = {
  \key bf \major \time 2/4
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
