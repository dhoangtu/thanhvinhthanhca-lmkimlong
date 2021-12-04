% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Kiếp Phù Du"
  composer = "Tv. 48"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 a8 |
  a8. c16 d, (f) g8 |
  g4. e8 |
  e8. g16 f8 d |
  c4 r8 f |
  f8. g16 d8 f16 (g) |
  a4. a8 |
  g8. c16 e, (d) c8 |
  f2 \bar "||" \break
  
  f8. a16 g8 f |
  d4. c8 |
  d (f) d f |
  g2 |
  bf8. g16 bf8 c |
  c4. a16 (g) |
  d8 (c) e g |
  f4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Nghe đây hết thảy chư dân,
      nghe đây tất cả nhân trần,
      Lê dân với hàng quyền quí,
      Cơ bần với hạng giầu sang.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Nghe tôi nói lời khôn ngoan,
	    nghe câu ví trên cung đàn,
	    Bao nhiêu kẻ cậy giầu có
	    Không chuộc lấy mình được đâu.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Nhân gian hết thảy tiêu vong,
	    khôn ngoan lẫn kẻ ngu đần,
	    Bao nhiêu sản nghiệp bỏ hết
	    Duy còn nấm mồ phủ thân.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Bao nhiêu những kẻ kiêu căng
	    nay nhao xuống âm phủ rồi,
	    Riêng tôi Chúa đà giải thoát
	    Khỏi ngục tử thần ngàn thu.
    }
  >>
  \set stanza = "ĐK:"
  Dù sống trong danh vọng
  mà chẳng được trường sinh,
  Con người đâu có khác thú vật phải chết đi.
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 10\mm
  bottom-margin = 10\mm
  left-margin = 10\mm
  right-margin = 10\mm
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
  \key f \major \time 2/4
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
        \notBePhu -3 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
