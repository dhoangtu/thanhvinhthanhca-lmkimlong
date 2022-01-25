% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Linh Hồn Tôi Ca Ngợi"
  composer = "Lc. 1,46-55"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 g16 d |
  g8 g fs a |
  b4. a16 d |
  b8 a e fs ~ |
  fs a a d, |
  g2 ~ |
  g4 r8 \bar "||" \break
  b16 b |
  b8 c d b |
  e4. a,16 a |
  a8 a c a |
  b4 r8 b16 g |
  a8 fs d c' ~ |
  c b a d |
  g,2 ~ |
  g4 r8 \bar "||"
}

nhacPhienKhucAlto = \relative c'' {
  r8 |
  R2*5
  r4.
  g16 g |
  g8 a b g |
  c4. fs,16 fs |
  fs8 fs a fs |
  g4 r8 g16 e |
  c8 d b e ~ |
  e g fs fs |
  g2 ~ |
  g4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Linh hồn tôi ca ngợi Thiên Chúa,
      Thần trí tôi reo mừng trong Đấng Cứu độ tôi.
      Vì Ngài đà dủ thương nhìn tới,
      Phận mọn hèn tỳ nữ Ngài đây
      Khiến từ nay muôn đời sẽ khen tôi phục lộc.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Bao kỳ công tay toàn năng Chúa
	    tạo tác cho tôi này,
	    Danh Chúa thánh thiện thay.
	    Từ đời này trải qua đời khác,
	    Ngài một niềm từ ái dủ thương
	    với những ai chân thành
	    vẫn luôn sợ kính Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Tay Ngài dương oai thật mạnh mẽ
	    mà đánh cho tan tành bao trí ý tự kiêu.
	    Ngài hạ bệ kẻ uy quyền xuống,
	    mà lại dìu người khiêm nhượng lên,
	    Kẻ nghèo ban dư đầy,
	    lũ sang giầu khánh lận.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Đây Ngài luôn bang trợ tôi tớ là Ít -- ra -- en này
	    như hứa với tổ tiên.
	    Vì Ngài hồi tưởng bao tình nghĩa
	    cùng tổ phụ là Ap -- bra -- ham,
	    với cả miêu duệ người đến muôn ngàn thế hệ.
    }
  >>  
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
        \notBePhu -3 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #0.8
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
